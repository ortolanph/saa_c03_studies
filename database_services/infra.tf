# Comment this if you don't want RDS
#module "network" {
#  source = "./network"
#
#  workspace = "chapter05"
#}
#
## Comment this if you don't want RDS with replica
#module "rds" {
#  source = "./rds"
#
#  security_group_id = module.network.database_security_group_id
#  subnets           = module.network.database_subnets
#  username          = var.rds_username
#  password          = var.rds_password
#  workspace         = "chapter05"
#}

module "dynamo" {
  source = "modules/dynamodb"

  workspace = "chapter05"
}
