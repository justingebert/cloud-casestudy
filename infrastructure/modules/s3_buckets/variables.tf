variable "source_bucket_name" {
  type        = string
  description = "Name of the source S3 bucket"
}

variable "dest_bucket_name" {
  type        = string
  description = "Name of the destination S3 bucket"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
}
