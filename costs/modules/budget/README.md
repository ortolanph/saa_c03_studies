<!-- BEGIN_TF_DOCS -->
# Costs

Creates a Simple Budget.

## Notifications

**Subscribers**:

* paulo.ortolan@gmail.com
* paulo.ortolan.pt@gmail.com
* paulo.ortolan.work@gmail.com

**Budget UNIT**: **USD**

| # | Comparison | Type | Threshold |
|:-:|:----------:|:----:|:---------:|
| 1 | GREATHER_THAN | ACTUAL | 30% |
| 2 | GREATHER_THAN | ACTUAL | 50% |
| 3 | GREATHER_THAN | ACTUAL | 80% |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.default_budget](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| workspace | The workspace to be used on naming and tags | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| budget\_name | n/a |
| budget\_period | n/a |
<!-- END_TF_DOCS -->    