terraform {
  backend "s3" {
    bucket = "iac-s3-backend"
    key    = "prod/eks/terraform.tfstate"
    region = "ap-south-1"
  }
}
