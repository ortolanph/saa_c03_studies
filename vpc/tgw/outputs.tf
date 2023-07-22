output "tgw_vpc_id" {
  value = aws_vpc.tgw_vpc.id
}

output "tgw_subnet_id" {
  value = aws_subnet.tgw_subnet.id
}

output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.tgw_transit_gateway.id
}

output "transit_gateway_default_route_table_id" {
  value = aws_ec2_transit_gateway.tgw_transit_gateway.association_default_route_table_id
}