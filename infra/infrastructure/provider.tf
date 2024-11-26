terraform {
  required_version = ">= 1.3"

  backend "s3" {
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.16.2"
    }
  }
}

provider "aws" {
  region = var.region
}

# IF YOU WANT TO USE MULTI REGION WITH AWS BACKUP, YOU MUST DECLARE 1 PROVIDER PER REGION

#EXAMPLE BELOW

# provider "aws" {
#   alias  = "primary"
#   region = var.primary_region
# }

# provider "aws" {
#   alias  = "secondary"
#   region = var.secondary_region
# }
