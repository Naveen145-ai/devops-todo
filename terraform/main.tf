terraform {
  required_version = ">= 1.2"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = ">= 19.0.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  node_groups = {
    default = {
      desired_capacity = 1
      max_capacity     = 2
      instance_types   = ["t3.medium"]
    }
  }
}

output "cluster_name" {
  value = module.eks.cluster_id
}
