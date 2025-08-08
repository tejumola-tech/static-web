🌍 CloudFront + S3 Static Website with Terraform

As my Terraform journey continues, I recently worked on a project to deploy a geo-distributed static website.

The setup uses:

Amazon S3 – To store HTML, CSS, and other static assets   # other use, you have to use your own html file path 

Amazon CloudFront – As a global CDN to deliver content quickly and securely to users worldwide

🔧 Project Highlights:

S3 bucket hosting the static site content

CloudFront distribution to serve content from edge locations

IAM policy granting CloudFront permission to read from S3

(Optional) S3 Versioning for data protection and rollback capability

All provisioned and automated with Infrastructure as Code (IaC) using Terraform

💡 Why CloudFront + S3?
This combination allows websites to load faster globally, improves reliability, and reduces latency — all while being cost-effective and easy to scale.

📂 GitHub Repository:
https://github.com/tejumola-tech/static-web

This project gave me deeper insight into building cloud infrastructure with Terraform and reinforced the power of IaC in delivering secure, scalable solutions.

#Terraform #AWS #CloudFront #S3 #StaticWebsite #DevOps #InfrastructureAsCode #CloudComputing #CDN
