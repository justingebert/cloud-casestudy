resource "aws_s3_bucket" "source_bucket" {
  bucket = var.source_bucket_name

  tags = {
    Name        = "Source Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "dest_bucket" {
  bucket = var.dest_bucket_name

  tags = {
    Name        = "Destination Bucket"
    Environment = var.environment
  }
}

#test for apprunner access
/* resource "aws_s3_bucket_public_access_block" "source_public_access_block" {
  bucket = aws_s3_bucket.source_bucket.id

  block_public_acls   = true
  block_public_policy = true
}
 */