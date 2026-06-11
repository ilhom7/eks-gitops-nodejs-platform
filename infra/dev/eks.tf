module "eks" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v21.23.0"

  name               = var.cluster_name
  kubernetes_version = var.cluster_version

  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnets

  addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    default = {
      name = "default-node-group"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1



      subnet_ids = module.vpc.private_subnets

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
      }
    }
  }

  tags = local.common_tags
}