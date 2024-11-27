########### GENERICS ###########
region     = "us-east-2"
env        = "training"
project    = "devops-playground-pei"
account_id = "721133465773"

########### VPC ###########
cidr_block         = "172.25.0.0/16"
availability_zones = ["us-east-2a", "us-east-2b"]
public_subnets     = ["172.25.100.0/24"]
private_subnets    = ["172.25.0.0/24", "172.25.1.0/24"]

######### RDS ###########
secret_password_id      = "pei-training/devops/db"
db_name                 = "postgres"
engine                  = "postgres"
engine_version          = "13.15"
rds_storage             = "20"
rds_instance_class      = "db.t3.micro"
backup_retention_period = 7

######### EC2 ###########
ec2_first_name = "ec2_first"
ec2_second_name = "ec2_second"
ec2_key_name = "ec2-key-name"
amiid                 = "ami-09694bfab577e90b0"
instance_type         = "t2.micro"
root_disk_volume_size = 100

######### ECR ###########
ecr_repositories = [
  {
    name        = "pei-training-client",
    max_images  = 10
  },
    {
    name        = "pei-training-api",
    max_images  = 10
  }
]
