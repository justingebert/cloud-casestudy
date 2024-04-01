data "archive_file" "lambda" {
  //source_file = "${path.module}/../src/lambda.js"
  source_dir  = "${path.module}/../src/lambda/"
  output_path = "${path.module}/lambda/lambda.zip"
  type        = "zip"
}

resource "aws_lambda_function" "image_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/lambda/lambda.zip"
  function_name = "processImage"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "nodejs20.x"

  architectures = ["x86_64"]
  timeout     = 15

  environment {
    variables = {
      DEST_BUCKET = aws_s3_bucket.dest_bucket.bucket
    }
  }
}

#event trigger
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.source_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.image_lambda.arn
    events              = ["s3:ObjectCreated:*"]
/*     filter_prefix       = "uploads/"
    filter_suffix       = ".jpg"  */   
  }

  depends_on = [aws_lambda_permission.allow_s3_invocation]
}

resource "aws_lambda_permission" "allow_s3_invocation" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.image_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.source_bucket.arn
}