# implement versioning later
resource "aws_s3_bucket" "source_bucket" {
  bucket = "jg-source-bucket-rb"

tags = {
    Name        = "Sourcebucket"
    Environment = "Dev"
  }

}

/* resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
} */


resource "aws_s3_bucket" "dest_bucket" {
  bucket = "jg-dest-bucket-rb"

tags = {
    Name        = "Destiantionbucket"
    Environment = "Dev"
  }

}

resource "aws_s3_bucket_public_access_block" "allow_public_access" {
  bucket = aws_s3_bucket.source_bucket.id

  block_public_acls   = false
  block_public_policy = false
}




