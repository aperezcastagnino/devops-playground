variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment to deploy resources in."
  type        = string
  default     = "dev"
}

variable "description" {
  description = "Description of the VPN client endpoint."
  type        = string
}

variable "server_certificate_arn" {
  description = "ARN of the server certificate for the VPN endpoint."
  type        = string
}

variable "root_certificate_chain_arn" {
  description = "ARN of the root certificate chain for the VPN endpoint."
  type        = string
}

variable "cloudwatch_log_group" {
  description = "Name of the CloudWatch log group for connection logs."
  type        = string
}

variable "cloudwatch_log_stream" {
  description = "Name of the CloudWatch log stream for connection logs."
  type        = string
}

variable "dns_servers" {
  description = "List of DNS servers for the VPN endpoint."
  type        = list(string)
  default     = []
}

variable "split_tunnel" {
  description = "Whether to enable split-tunnel for the VPN endpoint."
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC to associate the VPN client endpoint with."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to associate the VPN client endpoint with."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the VPN client endpoint."
  type        = list(string)
}

variable "transport_protocol" {
  description = "List of transport protocols to enable for the VPN client endpoint."
  type        = string
  default     = "udp"
}

variable "target_network_cidr" {
  description = "CIDR block for the VPN client endpoint."
  default     = "10.0.0.0/16"
}

variable "vpn_cidr_block" {
  description = "CIDR block for the VPN client endpoint."
  default     = "10.200.0.0/22"
}

variable "vpn_name" {
  description = "Name for the VPN client endpoint."
  type        = string
}