# /modules/lambda/variables.tf
variable "source_dir" {
  description = "The source directory for the lambda function"
  type        = string
}

variable "output_path" {
  description = "The output path for the lambda function"
  type        = string
}

variable "filename" {
  description = "The filename for the lambda function"
  type        = string
}

variable "function_name" {
  description = "The name of the lambda function"
  type        = string
}

variable "handler" {
  description = "The handler for the lambda function"
  type        = string
}

variable "runtime" {
  description = "The runtime for the lambda function"
  type        = string
}

variable "architecture" {
  description = "The architectures for the lambda function"
  type        = list(string)
}

variable "timeout" {
  description = "The timeout for the lambda function"
  type        = number
}

variable "environment_variables" {
  description = "The environment variables for the lambda function"
  type        = map(string)
}

variable "source_bucket_name" {
  description = "The source S3 bucket for the lambda function"
  type        = string
}

variable "source_bucket_arn" {
  description = "The source S3 bucket arn"
  type        = string
}

variable "source_bucket_id" {
  description = "The source S3 bucket id"
  type        = string
}

variable "dest_bucket_arn" {
  description = "The destination S3 bucket arn"
  type        = string
  
}