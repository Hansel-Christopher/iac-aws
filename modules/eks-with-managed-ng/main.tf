locals {
  name            = var.name
  cluster_version = var.cluster_version
  region          = "ap-south-1"
}

data "aws_vpcs" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["default-vpc"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.vpc.ids[0]]
  }
  tags = {
    type = "private"
  }

}
data "aws_subnets" "eks" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.vpc.ids[0]]
  }
  tags = {
    type = "private"
  }

}


################################################################################
# EKS Module
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name                   = local.name
  cluster_version                = local.cluster_version
  cluster_endpoint_public_access = false

  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
      configuration_values = jsonencode({
        env = {
          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  vpc_id = data.aws_vpcs.vpc.ids[0]
  # Uses specifics subnets in different AZs for multi-AZ control and data plane
  subnet_ids               = data.aws_subnets.eks.ids
  control_plane_subnet_ids = data.aws_subnets.private.ids

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = var.instance_types
  }
  eks_managed_node_groups = {
    default_node_group = {
      enable_monitoring = var.enable_eks_monitoring
      # Container runtime optimised OS
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      # Ensures minimal downtime during EKS node scaling
      update_config = {
        max_unavailable_percentage = 33
      }
      min_size                   = var.ng_min_size
      max_size                   = var.ng_max_size
      desired_size               = var.ng_desired_size
      disk_size                  = 50
      use_custom_launch_template = false

      taints = var.taints

      create_iam_role = true
      iam_role_name   = "${local.name}-role"
      # Restricted node IAM role permissions
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }
    }
  }
}

module "eks_control_plane_alarm" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 3.0"

  alarm_name                = "eks-api-latency-high"
  alarm_description         = "This alarm monitors high API server latency."
  namespace                 = "AWS/EKS"
  metric_name               = "apiserver_request_latencies"
  statistic                 = "Average"
  period                    = 60
  evaluation_periods        = 2
  threshold                 = 300000
  comparison_operator       = "GreaterThanThreshold"
  alarm_actions             = var.sns_notification_arn
  insufficient_data_actions = []
  treat_missing_data        = "missing"

  dimensions = {
    ClusterName = module.eks.cluster_name
  }
}
