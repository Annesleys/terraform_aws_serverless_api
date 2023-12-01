variable "lamda_invoke_arn" {
  type = string
  description = "Lambda invoke arn"
}

variable "lambda_function_name" {
  type = string
  description = "Lambda Function Name"
}

variable "region" {
  type        = string
  description = "default region to deploy"
}

variable "env" {
  type        = string
  description = "Environment Name"
}
