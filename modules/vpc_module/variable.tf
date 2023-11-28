variable "cidr_block" {
  type = string
}

variable "public_subnet" {
  type = list(any)
}

variable "private_subnet" {
  type = list(any)
}

variable "public_subnet_name" {
  type = list(any)
  default = [
    "public_subnet_1",
    "public_subnet_2"

  ]
}

variable "private_subnet_name" {
  type = list(any)
  default = [
    "private_subnet_1",
    "private_subnet_2"

  ]
}
