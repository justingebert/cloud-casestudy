
//app runner role
data "aws_iam_policy_document" "assume_role_app_runner" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [
        "apprunner.amazonaws.com",
        "build.apprunner.amazonaws.com",
        "tasks.apprunner.amazonaws.com",
        
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "app_runner_service_role" {
  name = "app-runner-service-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_app_runner.json
}

resource "aws_iam_role_policy_attachment" "app_runner_access" {
  role       = aws_iam_role.app_runner_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_iam_policy" "app_runner_s3_access" {
  name        = "app-runner-s3-access-policy"
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
        Resource = "${var.source_bucket_arn}/*"
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
  service_name = var.service_name

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.app_runner_service_role.arn
    }
    image_repository {
      image_configuration {
        port = "3000"
        runtime_environment_variables = {
          AWS_SDK_LOAD_CONFIG = "1"
          AWS_NODEJS_CONNECTION_REUSE_ENABLED = "1"
          S3_BUCKET_NAME = var.source_bucket_arn
    }
      }
      image_identifier      = var.image_repository
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = false

    

  }

  tags = {
    Name = "rb-casestudy-api"
  }
}

