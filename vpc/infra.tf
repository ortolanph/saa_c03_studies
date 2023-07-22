module "simple_vpc" {
  source  = "./simple"
  version = "1"

  workspace = local.workspace
}

module "transit_gateway" {
  source  = "./tgw"
  version = "1"

  simple_vpc_id             = module.simple_vpc.vpc_id
  simple_vpc_cidr           = module.simple_vpc.vpc_cidr
  simple_vpc_subnet_id      = module.simple_vpc.subnet_id
  simple_vpc_route_table_id = module.simple_vpc.main_route_table_id
  workspace                 = local.workspace

}