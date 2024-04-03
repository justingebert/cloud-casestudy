variable "image_sizes" {
  description = "String of image sizes to transcode to"
  type        = string
  default     = "2048,1024"
}

/* variable "image_sizes" {
  description = "List of image sizes for the Lambda function"
  type        = list(number)
  default     = [2048, 1024]
}
 */