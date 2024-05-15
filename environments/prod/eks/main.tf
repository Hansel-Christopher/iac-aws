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


module "eks" {
  source                   = "../../../modules/eks-with-managed-ng"
  name                     = "prod-eks"
  vpc_id                   = data.aws_vpcs.vpc.ids[0]
  control_plane_subnet_ids = data.aws_subnets.eks.ids
  node_group_subnet_ids    = data.aws_subnets.private.ids
  ng_min_size              = 1
  ng_desired_size          = 1
  ng_max_size              = 5
  instance_types           = ["t3.large"]
  enable_eks_monitoring    = true
}
