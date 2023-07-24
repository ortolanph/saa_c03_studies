module "network" {
  source = "./network"

  workspace = "chapter05"
}

module "rds" {
  source = "./rds"

  security_group_id = module.network.database_security_group_id
  subnets           = module.network.database_subnets
  username          = var.rds_username
  password          = var.rds_password
  workspace         = "chapter05"
}
