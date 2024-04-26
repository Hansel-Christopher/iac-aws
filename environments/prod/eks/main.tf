module "eks" {
  source                = "../../../modules/eks-with-managed-ng"
  name                  = "prod-eks"
  enable_eks_monitoring = true
  ng_min_size           = 1
  ng_desired_size       = 1
  ng_max_size           = 3
  instance_types        = ["t4.large"]

}
