variable "profile" {
  type        = string
  description = "deployment_profile"
}
variable "region" {
  type        = string
  description = "default region to deploy"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for your VPC"
}

variable "public_subnet" {
  type        = list(any)
  description = "List of public subnet with prefix"
}

variable "private_subnet" {
  type        = list(any)
  description = "List of private subnet with prefix"
}

variable "env" {
  type        = string
  description = "List of environments"
}