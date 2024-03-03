run "create_budget" {
  command = apply

  assert {
    condition     = module.budget.budget_name == "chapter13_budget"
    error_message = "Invalid budget name"
  }

  assert {
    condition     = module.budget.budget_period == "MONTHLY"
    error_message = "Invalid budget period"
  }
}