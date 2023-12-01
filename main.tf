terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

#################### Creating api ####################

module "api" {
  source               = "./modules/api_module/"
  lamda_invoke_arn     = module.lambda.lambda_invoke_arn
  lambda_function_name = module.lambda.lambda_function_name
  region               = var.region
  env                  = var.env
}

#################### Creating Lambda ####################

module "lambda" {
  source        = "./modules/lambda_module/"
  s3_bucket     = var.s3_bucket
  artifact_name = var.artifact_name
  env                  = var.env
}
