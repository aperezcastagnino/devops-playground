module "vpc" {
  source             = "./modules/vpc"
  env                = var.env
  project            = var.project
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  cidr_block         = var.cidr_block
}

module "rds" {
  source                  = "./modules/rds"
  project                 = var.project
  env                     = var.env
  vpc_id                  = module.vpc.vpc_id
  private_subnets         = module.vpc.private_subnets
  db_name                 = var.db_name
  secret_password_id      = var.secret_password_id
  engine                  = var.engine
  engine_version          = var.engine_version
  rds_storage             = var.rds_storage
  rds_instance_class      = var.rds_instance_class
  identifier              = "${var.project}-${var.env}-db"
  backup_retention_period = var.backup_retention_period
  cidr_block              = var.cidr_block
  rds_public              = var.rds_public
}

module "ec2_iam_profile" {
  source  = "./modules/ec2-iam-profile"
  env     = var.env
  project = var.project
}

module "ec2-first" {
  source                = "./modules/ec2"
  region                = var.region
  amiid                 = var.amiid
  env                   = var.env
  project               = var.project
  subnet_id             = module.vpc.private_subnets[0]
  create_machine_script = "create_machine_script.tmpl"
  key_name              = var.ec2_key_name
  instance_type         = var.instance_type
  root_disk_volume_size = var.root_disk_volume_size
  vpc_id                = module.vpc.vpc_id
  iam_instance_profile  = module.ec2_iam_profile.ec2_profile_name
  ec2_name = var.ec2_first_name
}

module "ec2-second" {
  source                = "./modules/ec2"
  region                = var.region
  amiid                 = var.amiid
  env                   = var.env
  project               = var.project
  subnet_id             = module.vpc.public_subnets[0]
  create_machine_script = "create_machine_script.tmpl"
  key_name              = var.ec2_key_name
  instance_type         = var.instance_type
  root_disk_volume_size = var.root_disk_volume_size
  vpc_id                = module.vpc.vpc_id
  iam_instance_profile  = module.ec2_iam_profile.ec2_profile_name
  ec2_name = var.ec2_second_name
}

module "ecr" {
  source           = "./modules/ecr"
  ecr_repositories = var.ecr_repositories
}
