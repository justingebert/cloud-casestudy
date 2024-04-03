output "apprunner_service_arn" {
  description = "The ARN of the App Runner service"
  value       = aws_apprunner_service.rb_apprunner_service.arn
}