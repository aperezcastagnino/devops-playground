
# General variables
variable "region" {
  description = "Region where the infrastructure will be hosted (us-east-2, us-east-1, etc)"
  type        = string
}

variable "env" {
  description = "Name of the environment we are managing (staging, rc, production)"
  type        = string
}
variable "app" {
  default = "dev"
}
variable "project" {
  description = "The name of the project"
}

variable "account_id" {
  description = "AWS account id"
}

# VPC variables
variable "cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of IPv4 CIDR blocks used by the public subnets"
}

variable "private_subnets" {
  description = "List of IPv4 CIDR blocks used by the private subnets"
}

variable "availability_zones" {
  description = "List of availability zones used by the subnets"
}

# RDS variables
variable "secret_password_id" {
  description = "Name of the secret where the RDS credentials are stored. It needs to exist and have the keys `username` and `password`"
}

variable "db_name" {
  description = "Database name"
}

variable "engine" {
  description = "Database engine"
}

variable "engine_version" {
  description = "Version of the engine to be used"
}

variable "rds_storage" {
  description = "RDS disk size"
}

variable "rds_instance_class" {
  description = "Instance size for RDS"
}

variable "backup_retention_period" {
  description = "RDS backups retention period in days"
  default     = 7
}

variable "rds_public" {
  description = "Is the RDS publicly accesible?"
  default     = false
}

# EC2 variables
variable "amiid" {
  description = "The amiid used by the instance"
}

variable "ec2_key_name" {
  description = "Key to be used by the EC2"
  default     = "default-first_key_name"
}

variable "instance_type" {
  description = "Instance type for the EC2"
  default     = "t2.micro"
}

variable "root_disk_volume_size" {
  description = "Root disk volume size"
  default     = "100"
}

variable "ec2_first_name" {
  description = "Key to be used by the EC2"
  default     = "default-first_name"
}

variable "ec2_second_name" {
  description = "Name to be used by the EC2"
  default     = "default-second_name"
}


# ECR variables
variable "ecr_repositories" {
  description = "List of ECR repositories to create. The format of each repository needs to be a dict with the keys `name` and `max_images`"
  default     = []
}
