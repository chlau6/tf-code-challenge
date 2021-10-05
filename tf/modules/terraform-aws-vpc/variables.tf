variable "project" {
  description = "project name"
  type = string
}

variable "region" {
  description = "aws region, e.g. ap-southeast-1"
  type = string
}

variable "az" {
  description = "availability zone, must match the length of public subnet / private subnet"
  type = list(string)
}

variable "vpc_cidr" {
  description = "vpc cidr block"
  type = string
}

variable "public_subnet_cidr" {
  description = "public subnet cidr, at most 3 public subnets"
  type = list(string)
}

variable "private_subnet_cidr" {
  description = "private subnet cidr, at most 3 private subnets"
  type = list(string)
}

variable "is_custom" {
  description = "default or custom subnet creation"
  type = bool
}

variable "igw_id" {
  description = "for level 3"
  type = string
  default = ""
}

variable "nat_gw_id" {
  description = "for level 3"
  type = string
  default = ""
}
