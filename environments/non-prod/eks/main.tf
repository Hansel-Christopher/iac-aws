module "eks" {
  source                = "../../../modules/eks-with-managed-ng"
  name                  = "non-prod-eks"
  enable_eks_monitoring = false
  ng_min_size           = 1
  ng_desired_size       = 2
  ng_max_size           = 4
  instance_types        = ["t4.large"]
}
