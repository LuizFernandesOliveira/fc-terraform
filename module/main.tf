module "fullcycle-vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}

module "fullcycle-eks" {
  source = "./modules/eks"
  prefix = var.prefix
  aws_vpc_id = module.fullcycle-vpc.vpc_id
  cluster_name = var.cluster_name
  log_retention_days = var.log_retention_days
  aws_subnet_ids = module.fullcycle-vpc.subnet_ids
  desired_size = var.desired_size
  min_size = var.min_size
  max_size = var.max_size
}