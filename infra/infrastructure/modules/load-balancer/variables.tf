variable "env" {
  description = "Name of the environment we are managing (staging, rc, production)"
}

variable "project" {
  description = "The name of the project"
}

variable "vpc_id" {
  description = "Id of the VPC used by the load balancer"
}

variable "app" {
  description = "Name of the app"
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "health_check_path" {
  description = "Path where you want the health check to be done"
}

variable "matcher" {
  description = "Status code to be accepted by health check"
}

variable "enable_tls" {
  description = "Habilitar o deshabilitar TLS en el balanceador de carga"
  type        = bool
  default     = false
}

variable "cert_arn" {
  default = null
}

variable "cidr_block" {}