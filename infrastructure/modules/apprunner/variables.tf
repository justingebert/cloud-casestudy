variable "service_name" {
  description = "The name of the App Runner service"
  type        = string
}

variable "image_repository" {
  description = "The identifier of an image repository"
  type        = string
}

variable "source_bucket_arn" {
  description = "The ARN of the source S3 bucket"
  type        = string
  
}