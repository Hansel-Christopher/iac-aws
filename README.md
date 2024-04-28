# iac-aws
Collection of IAC Terraform templates to manage AWS resources (EKS, IAM Roles, CloudWatch Alarms, Security groups)

## Repository Structure

.
├── environments/
│   ├── non-prod/
│   └── prod/
│       └── eks/
│           ├── backend.tf
│           ├── main.tf
│           └── versions.tf
└── **modules/**:/
    └── **eks-with-managed-ng/**/
        ├── **backend.tf**
        ├── **main.tf**
        ├── **variables.tf**
        ├── **versions.tf**
        └── **outputs.tf**

- **.github/**: Contains GitHub Actions CI/CD workflows
- **.gitignore**: Patterns to ignore when commiting files to Git repository



## Prerequisites
- Terraform
- AWS cli installed with credentials configured

## Usage

1. cd `environments/prod/eks`
2. Initialise terraform - `terraform init`
3. Update terraform configuration
4. Create a pull request
5. CI checks will run to provide a summary of changes
6. Terraform apply runs after PR is approved and merged to `main`


## Pre-commit Hooks

- To ensure code standards and quality, pre-commit hook checks are automatically enforced before code is committed to the repository.
- The configuration for pre-commit can be found in `.pre-commit-config.yaml`
