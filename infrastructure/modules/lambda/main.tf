# /modules/lambda/main.tf
data "archive_file" "lambda" {
  source_dir  = var.source_dir
  output_path = "${var.output_path}/lambda.zip"
  type        = "zip"
}

resource "aws_lambda_function" "image_lambda" {
  filename      = var.filename
  function_name = var.function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.runtime

  architectures = var.architecture
  timeout     = var.timeout

  environment {
    variables = var.environment_variables
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.source_bucket_id

  lambda_function {
    lambda_function_arn = aws_lambda_function.image_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3_invocation]
}

resource "aws_lambda_permission" "allow_s3_invocation" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.image_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.source_bucket_arn
}