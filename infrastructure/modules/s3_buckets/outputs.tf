output "source_bucket_name" {
  value       = aws_s3_bucket.source_bucket.bucket
  description = "The name of the source S3 bucket"
}

output "dest_bucket_name" {
  value       = aws_s3_bucket.dest_bucket.bucket
  description = "The name of the destination S3 bucket"
}

output "source_bucket_arn" {
  value       = aws_s3_bucket.source_bucket.arn
  description = "The ARN of the source S3 bucket"
}

output "dest_bucket_arn" {
  value       = aws_s3_bucket.dest_bucket.arn
  description = "The ARN of the destination S3 bucket"
}

output "source_bucket_id" {
  value       = aws_s3_bucket.source_bucket.id
  description = "The ID of the source S3 bucket"
}