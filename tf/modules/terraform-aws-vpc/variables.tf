variable "project" {
  description = "project name"
  type        = string
}

variable "region" {
  description = "aws region, e.g. ap-southeast-1"
  type        = string
}

variable "vpc_cidr" {
  description = "vpc cidr block"
  type        = string
}

variable "public_subnet" {
  description = "public subnet cidr with az"
  type        = list(object({ cidr = string, availability_zone = string }))
}

variable "private_subnet" {
  description = "private subnet cidr with az"
  type        = list(object({ cidr = string, availability_zone = string }))
}

variable "is_custom" {
  description = "default or custom subnet creation"
  type        = bool
}

variable "igw_id" {
  description = "for level 3, if is_custom is set to true, we will put the route to this igw_id in route table"
  type        = string
  default     = ""
}

variable "nat_gw_id" {
  description = "for level 3, if is_custom is set to true, we will put the route to this nat_gw_id in route table"
  type        = string
  default     = ""
}
