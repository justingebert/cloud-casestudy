terraform {
  cloud {
    organization = "justingebert"

    workspaces {
      name = "rb-casestudy-dev"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "s3_buckets" {
  source = "./modules/s3_buckets"

  source_bucket_name = "jg-source-bucket-rb"
  dest_bucket_name   = "jg-dest-bucket-rb"
  environment        = "Dev"
}

module "lambda" {
  source = "./modules/lambda"

  source_dir           = "${path.root}/../src/lambda/"
  output_path          = "${path.root}/lambda/"
  filename             = "${path.root}/lambda/"
  function_name        = "processImage"
  handler              = "lambda.handler"
  runtime              = "nodejs20.x"
  architecture         = ["x86_64"]
  timeout              = 15
  environment_variables = {
    "DEST_BUCKET" = "aws_s3_bucket.dest_bucket.bucket"
    "IAMGE_SIZES" = "var.image_sizes"
  }
  source_bucket_name = "${module.s3_buckets.source_bucket_name}"
  source_bucket_arn  = "${module.s3_buckets.source_bucket_arn}"
  source_bucket_id = "${module.s3_buckets.source_bucket_id}"
  dest_bucket_arn = "${module.s3_buckets.dest_bucket_arn}"
}

module "apprunner" {
  source           = "./modules/apprunner"

  service_name     = "rb-casestudy-api"
  image_repository = "339713147039.dkr.ecr.eu-central-1.amazonaws.com/rb-casestuy-ecr:latest"
  source_bucket_arn = "module.s3_buckets.source_bucket_arn"
}