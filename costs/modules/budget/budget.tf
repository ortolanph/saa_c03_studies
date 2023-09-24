resource "aws_budgets_budget" "default_budget" {
  name         = "${var.workspace}_budget"
  budget_type  = "COST"
  limit_amount = "10"
  limit_unit   = local.budget_unit
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "ACTUAL"
    threshold                  = 50
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = local.subscribers
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    notification_type          = "ACTUAL"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = local.subscribers
  }
}
