output "budget_name" {
  value = aws_budgets_budget.default_budget.name
}

output "budget_period" {
  value = aws_budgets_budget.default_budget.time_unit
}
