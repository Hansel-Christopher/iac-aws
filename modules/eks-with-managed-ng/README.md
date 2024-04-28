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
| <a name="module_eks_control_plane_alarm"></a> [eks\_control\_plane\_alarm](#module\_eks\_control\_plane\_alarm) | terraform-aws-modules/cloudwatch/aws//modules/metric-alarm | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_subnets.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpcs.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpcs) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Cluster version to bootstrap with | `string` | `"1.29"` | no |
| <a name="input_enable_eks_monitoring"></a> [enable\_eks\_monitoring](#input\_enable\_eks\_monitoring) | Flag to disable/enable the CW eks monitoring | `bool` | `false` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | List of instance types to be used for the nodegroups | `list(string)` | <pre>[<br>  "t4.large"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the eks cluster | `string` | `"eks"` | no |
| <a name="input_ng_desired_size"></a> [ng\_desired\_size](#input\_ng\_desired\_size) | Node group desired node count | `number` | `1` | no |
| <a name="input_ng_max_size"></a> [ng\_max\_size](#input\_ng\_max\_size) | Node group maximum node count | `number` | `1` | no |
| <a name="input_ng_min_size"></a> [ng\_min\_size](#input\_ng\_min\_size) | Node group minimum node count | `number` | `1` | no |
| <a name="input_node_group_ami_type"></a> [node\_group\_ami\_type](#input\_node\_group\_ami\_type) | Nodegroup AMI type | `string` | `"BOTTLEROCKET_x86_64"` | no |
| <a name="input_node_group_platform"></a> [node\_group\_platform](#input\_node\_group\_platform) | Node group platform type | `string` | `"bottlerocket"` | no |
| <a name="input_sns_notification_arn"></a> [sns\_notification\_arn](#input\_sns\_notification\_arn) | n/a | `list(string)` | `[]` | no |
| <a name="input_taints"></a> [taints](#input\_taints) | Taints to be applied on the nodes | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
<!-- END_TF_DOCS -->