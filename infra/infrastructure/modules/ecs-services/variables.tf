variable "account_id" {
  description = "AWS account id"
}

variable "project" {
  description = "The name of the project"
}

variable "env" {
  description = "Name of the environment we are managing (staging, rc, production)"
}

variable "region" {
  description = "Region where the infrastructure will be hosted (us-east-2, us-east-1, etc)"
}

variable "service_name" {
  description = "Name of the service"
}

variable "app" {
  description = "Name of the app"
}

variable "ecs_desired_count" {
  description = "Desired replicas for ecs autoscaling"
}

variable "max_capacity" {
  description = "Max replicas for ecs autoscaling"
}

variable "min_capacity" {
  description = "Min replicas for ecs autoscaling"
}

variable "ecr_repo_name" {
  description = "Name for the ECR repositoy used by the service"
}

variable "cpu_amount" {
  description = "Amount of CPU to be used with this task"
}

variable "memory_amount" {
  description = "Amount of RAM to be used with this task"
}

variable "docker_port" {
  description = "Port for the container"
}

variable "image_tag" {
  description = "Image tag (example: latest"
  default     = "latest"
}

variable "var_file" {
  description = "Env variables file"
}

variable "secrets_file" {
  description = "Secrets file"
}

variable "vpc_id" {
  description = "The VPC id used by the service"
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "private_subnets" {
  description = "List of private subnets"
}

variable "cluster_id" {
  description = "ECS custer id where the service will be executed"
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
}

variable "use_load_balancer" {
  description = "Whether to use a load balancer for the ECS service"
  type        = bool
  default     = false
}

variable "load_balancer_target_group" {
  description = "Target group to be used with the service. Only required if 'use_load_balancer' is set in true"
  default     = null
}

variable "load_balancer_security_group_id" {
  description = "Load balancer security group ID . Only required if 'use_load_balancer' is set in true"
  default     = null
}

variable "rollback_enabled" {
  description = "Boolean flag to enable/disable ecs rollbacks"
  type        = bool
  default     = true
}

variable "circuit_breaker_enabled" {
  description = "Boolean flag to enable/disable ecs circuit braker"
  type        = bool
  default     = true
}

variable "use_autodiscovery" {
  description = "Whether to use service autodiscovery"
  type        = bool
  default     = false
}

variable "discovery_name" {
  description = "dns name for your service"
  default     = null
}

variable "aws_service_discovery_private_dns_namespace" {
  description = "Name of the private hosted zone"
}

variable "cmd" {
  description = "cmd to execute with your task definition"
  default     = ""
}

variable "autoscaling_cpu_target" {
  description = "CPU target condition for autoscale the service"
  default     = 80
}

variable "autoscaling_ram_target" {
  description = "RAM target condition for autoscale the service"
  default     = 80
}

variable "capacity_provider" {
  description = "Choose between FARGATE or FARGATE_SPOT"
  default     = "FARGATE"
}

variable "efs_file_system_id" {}

variable "efs_access_point_id" {}

variable "include_efs_volume" {
  default = false
}