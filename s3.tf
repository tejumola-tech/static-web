
# S3 bucket for website files
resource "aws_s3_bucket" "staticwebsite_bucket" {
  bucket        = "my-static-site-${random_id.bucket_id.hex}"
  force_destroy = true
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

# Upload index.html from local/external drive
locals {
  website_files = fileset("/mnt/d/static-website", "**") # Recursively get all files
}

resource "aws_s3_object" "website_files" {
  for_each = { for file in local.website_files : file => file }

  bucket = aws_s3_bucket.staticwebsite_bucket.bucket
  key    = each.value
  source = "/mnt/d/static-website/${each.value}"

  content_type = lookup(
    {
      html = "text/html"
      css  = "text/css"
      js   = "application/javascript"
      png  = "image/png"
      jpg  = "image/jpeg"
      jpeg = "image/jpeg"
      gif  = "image/gif"
      svg  = "image/svg+xml"
      json = "application/json"
    },
    lower(join("", slice(split(".", each.value), length(split(".", each.value)) - 1, length(split(".", each.value))))),
  "application/octet-stream"
  )
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.staticwebsite_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.staticwebsite_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.cdn.arn
          }
        }
      },
      {
        Sid = "AllowCloudFrontOAIRead"
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.staticwebsite_bucket.arn}/*"
      }
    ]
  })
}
