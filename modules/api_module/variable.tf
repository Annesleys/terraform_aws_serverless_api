variable "lamda_invoke_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "region" {
  type        = string
  description = "default region to deploy"
}

variable "env" {
  type        = string
  description = "default region to deploy"
}
