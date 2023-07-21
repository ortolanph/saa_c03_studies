output "vpc_id" {
  value = module.simple_vpc.vpc_id
}

output "subnet_id" {
  value = module.simple_vpc.subnet_id
}

output "eni_id" {
  value = module.simple_vpc.eni_id
}

output "igw_id" {
  value = module.simple_vpc.igw_id
}

output "security_group_id" {
  value = module.simple_vpc.security_group_id
}