variable "workspace" {
  type        = string
  description = "The workspace to be used on naming and tags"
}

variable "security_group_id" {
  type        = string
  description = "The Security Group id"
}

variable "subnets" {
  type        = list(string)
  description = "The subnets created for the database"
}

variable "username" {
  type        = string
  description = "The User Name"
}

variable "password" {
  type        = string
  description = "The Password"
}
