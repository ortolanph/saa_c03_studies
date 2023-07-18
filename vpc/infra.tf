module "simple_vpc" {
  source = "./simple"

  workspace = local.workspace
  route_table_id = var.route_table_id
}
