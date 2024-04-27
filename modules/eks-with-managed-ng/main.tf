data "aws_caller_identity" "current" {}

locals {
  name            = var.name
  cluster_version = var.cluster_version
  region          = "ap-south-1"

  tags = {
    Name = local.name
    Team = "devops"
    Org  = "example"
  }
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


################################################################################
# EKS Module
################################################################################

#trivy:ignore:AVD-AWS-0104
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

  vpc_id     = data.aws_vpcs.vpc.ids[0]
  subnet_ids = data.aws_subnets.private.ids

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = var.instance_types
  }
  eks_managed_node_groups = {
    default_node_group = {
      use_custom_launch_template = false

      # Container runtime optimised OS
      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"

      disk_size    = 50
      min_size     = var.ng_min_size
      max_size     = var.ng_max_size
      desired_size = var.ng_desired_size

      enable_monitoring = var.enable_eks_monitoring

      # Ensures minimal downtime during EKS node scaling
      update_config = {
        max_unavailable_percentage = 33
      }

      taints = var.taints

      create_iam_role = true
      iam_role_name   = "${local.name}-role"
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }
    }
  }

  # Provide read-only access to 
  access_entries = {
    viewer_rbac = {
      principal_arn = aws_iam_role.this.arn
      policy_associations = {
        viewer = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }

  }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.0"

  key_name_prefix    = local.name
  create_private_key = true

  tags = local.tags
}
resource "aws_iam_role" "this" {
  name = "viewer"

  # Updated policy for assuming role by any IAM user or SSO users in the account
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "Example"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      },
    ]
  })

  tags = local.tags
}
