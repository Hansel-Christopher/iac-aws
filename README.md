# iac-aws
Collection of IAC Terraform templates to manage AWS resources (EKS, IAM Roles, CloudWatch Alarms, Security groups)

## Usage

1. cd `environments/prod/eks`
2. Initialise terraform - `terraform init`
3. Update terraform configuration
4. Create a pull request
5. CI checks will run to provide a summary of changes
6. Terraform apply runs after PR is approved and merged to `main`
