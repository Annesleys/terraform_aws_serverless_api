variable "profile" {
  type        = string
  description = "deployment_profile"
}
variable "region" {
  type        = string
  description = "default region to deploy"
}

variable "env" {
  type        = string
  description = "List of environments"
}

variable "s3_bucket" {
  type        = string
  description = "Artifect bucket"
}

variable "artifact_name" {
  type        = string
  description = "Artifect zip file"
}