variable "workspace" {
  type        = string
  description = "The workspace to be used on naming and tags"
}

variable "simple_vpc_id" {
  type        = string
  description = "The VPC Id from the simple_vpc module"
}

variable "simple_vpc_subnet_id" {
  type        = string
  description = "The Subnet id from the simple_vpc module"
}

variable "simple_vpc_route_table_id" {
  type        = string
  description = "The Route Table id from the simple_vpc module"
}

variable "simple_vpc_cidr" {
  type = string
  description = "The CIDR Block from the simple_vpc module VPC"
}