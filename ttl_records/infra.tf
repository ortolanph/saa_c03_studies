module "dynamo" {
  source = "modules/dynamodb"

  workspace = local.workspace
}
