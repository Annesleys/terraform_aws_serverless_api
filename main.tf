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

#################### Creating VPC ####################

module "vpc" {
  source         = "./modules/vpc_module/"
  cidr_block     = var.cidr_block
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet

}

#################### Creating Web Application ####################

module "api" {
  source         = "./modules/api_module/"
}