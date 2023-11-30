terraform {
  backend "s3" {
    bucket = "backend-terraform-anna"
    key    = "terraform.tfstate"
    region = "us-east-1"
    profile = "default"
  }
}
