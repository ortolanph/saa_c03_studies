output "vpc_id" {
  value = module.simple_vpc.vpc_id
}

output "vpc_cidr" {
  value = module.simple_vpc.vpc_cidr
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

output "main_route_table_id" {
  value = module.simple_vpc.main_route_table_id
}

output "tgw_vpc_id" {
  value = module.transit_gateway.tgw_vpc_id
}

output "tgw_subnet_id" {
  value = module.transit_gateway.tgw_subnet_id
}

output "transit_gateway_id" {
  value = module.transit_gateway.transit_gateway_id
}

output "transit_gateway_default_route_table_id" {
  value = module.transit_gateway.transit_gateway_default_route_table_id
}