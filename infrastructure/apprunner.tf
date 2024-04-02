//app runner role
resource "aws_iam_role" "app_runner_service_role" {
  name = "app-runner-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "build.apprunner.amazonaws.com"
        },
        Effect = "Allow",
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_access" {
  role       = aws_iam_role.app_runner_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_iam_policy" "app_runner_s3_access" {
  name        = "app-runner-s3-access-policy"
  path        = "/"
  description = "Policy for App Runner service to access S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::jg-source-bucket/*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_s3_access" {
  role       = aws_iam_role.app_runner_service_role.name
  policy_arn = aws_iam_policy.app_runner_s3_access.arn
}

//app runner service
resource "aws_apprunner_service" "rb_apprunner_service" {
  provider = aws.apprunner
  service_name = "rb-casestudy-api"

  source_configuration {
    authentication_configuration {
    access_role_arn = aws_iam_role.app_runner_service_role.arn
    }
    image_repository {
      image_configuration {
        port = "3000"
      }
      image_identifier      = "339713147039.dkr.ecr.eu-north-1.amazonaws.com/rb:latest"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = false

  }

  tags = {
    Name = "rb-casestudy-api"
  }
}

