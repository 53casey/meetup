variable "name" {
  type        = string
  description = "the name of your stack"
  default     = "meetup"
}

variable "aws_region" {
  default = "eu-west-3"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "private_subnet_1_cidr" {
  default = "10.0.0.0/20"
}

variable "private_subnet_2_cidr" {
  default = "10.0.32.0/20"
}

variable "public_subnet_1_cidr" {
  default = "10.0.16.0/20"
}

variable "public_subnet_2_cidr" {
  default = "10.0.48.0/20"
}




