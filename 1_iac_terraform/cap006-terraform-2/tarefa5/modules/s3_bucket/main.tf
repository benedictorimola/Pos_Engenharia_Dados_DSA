resource "aws_s3_bucket" "bamr_bucket" {
    bucket = var.bucket_name
    tags   = var.tags
  
}