# iac-aws
Collection of IAC Terraform templates to manage AWS resources (EKS, IAM Roles, CloudWatch Alarms, Security groups)

## Repository Structure

The repository is organised for a multi-tenant setup. Under each `environment` the folders are organised `service-wise`. Ex: `environments/prod/eks` contains the terraform configuration for the prod eks clusters.

The modules directory contains a collection of generic modules for different use-cases. These modules are source referenced by local path in the different environments. 

This pattern ensures minimal code duplication, consistency across environments and reduced-scale of statefiles (reduced blast radius).

```
    .
    ├── environments/
    │   ├── non-prod/
    │   └── prod/
    │       └── eks/
    │           ├── backend.tf
    │           ├── main.tf
    │           └── versions.tf
    └── modules/
        └── eks-with-managed-ng/
            ├── main.tf
            ├── variables.tf
            ├── versions.tf
            └── outputs.tf
```


## Prerequisites
- Terraform
- AWS cli installed with credentials configured

## Usage

1. cd `environments/prod/eks`
2. Initialise terraform - `terraform init`
3. Generate plan - `terraform plan`
4. Verify the resources to be created
4. Create the resources - `terraform apply`


You can also utilise the GH Actions workflow integrated in this repo by simply raising a PR against any of the terraform configurations in an environment

CI checks will run to provide a summary of changes

Terraform apply runs after PR is approved and merged to `main`


## Pre-commit Hooks

- To ensure code standards and quality, pre-commit hook checks are automatically enforced before code is committed to the repository.
- The configuration for pre-commit can be found in `.pre-commit-config.yaml`
