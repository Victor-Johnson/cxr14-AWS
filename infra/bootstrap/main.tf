data "aws_caller_identity" "current" {}

resource "random_id" "suffix" {
  byte_length = 4
}
locals {
  # Bucket names are globally unique, so the account ID makes a clash unlikely
  state_bucket_name = "cxr14-tfstate-${random_id.suffix.hex}"
}

resource "aws_s3_bucket" "state" {
  bucket        = local.state_bucket_name
  #force_destroy = true # allows `terraform destroy` to delete the bucket even if it still has objects in it

  lifecycle {
    prevent_destroy = true # Terraform refuses to delete this by accident
  }
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = "Enabled" # lets you recover a corrupted or overwritten state file
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}