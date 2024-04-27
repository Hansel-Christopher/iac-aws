module "eks" {
  source                = "../../../modules/eks-with-managed-ng"
  name                  = "prod-eks"
  enable_eks_monitoring = true
  ng_min_size           = 1
  ng_desired_size       = 2
  ng_max_size           = 4
  instance_types        = ["m6.large", "r6.large"]
}
