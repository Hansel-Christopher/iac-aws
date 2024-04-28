<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.47.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 20.0 |

## Resources

| Name | Type |
|------|------|
| [aws_subnets.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpcs.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpcs) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | describe your variable | `string` | `"1.29"` | no |
| <a name="input_enable_eks_monitoring"></a> [enable\_eks\_monitoring](#input\_enable\_eks\_monitoring) | (optional) describe your variable | `bool` | `false` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | describe your variable | `list(string)` | <pre>[<br>  "t4.large"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | (optional) describe your variable | `string` | `"eks"` | no |
| <a name="input_ng_desired_size"></a> [ng\_desired\_size](#input\_ng\_desired\_size) | description | `number` | `1` | no |
| <a name="input_ng_max_size"></a> [ng\_max\_size](#input\_ng\_max\_size) | description | `number` | `1` | no |
| <a name="input_ng_min_size"></a> [ng\_min\_size](#input\_ng\_min\_size) | description | `number` | `1` | no |
| <a name="input_taints"></a> [taints](#input\_taints) | (optional) describe your variable. | `list(any)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->