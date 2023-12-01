terraform {
  backend "s3" {
    bucket  = "test-ano-v"
    key     = "terraform.tfstate"
    region  = "eu-west-1"
    profile = "aps"
  }
}
