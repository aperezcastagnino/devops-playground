output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = module.rds.rds_endpoint
}

output "ec2_first_public_ip" {
  description = "EC2 First Public IP"
  value       = module.ec2-first.public_ip
}

output "ec2_first_private_ip" {
  description = "EC2 First Private IP"
  value       = module.ec2-first.private_ip
}

output "ec2_second_public_ip" {
  description = "EC2 Second Public IP"
  value       = module.ec2-second.public_ip
}

output "ec2_second_private_ip" {
  description = "EC2 Second Private IP"
  value       = module.ec2-second.private_ip
}
