variable "namespace" {
  type = string
  description = "Namespace (e.g. `cp` or `cloudposse`)"
}

variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "public_subnets" {
  type = list(string)
  description = "List of public subnets"
}

variable "alb_certificate_arn" {
  type = string
  default = ""
  description = "ARN of the certificate to use for HTTPS listener"
}

variable "region" {
  type = string
  description = "AWS region"
}

variable "private_subnets" {
  type = list(string)
  description = "List of private subnets"
}

variable "wordpress_version" {
  type = string
  default = "latest"
  description = "Wordpress version"
}

variable "db_host"{
  type = string
  description = "Database host"
}

variable "db_port"{
  type = string
  description = "Database port"
}

variable "db_user" {
  type = string
  description = "Database user"
}

variable "db_password" {
  type = string
  description = "Database password"
  sensitive = true
}

variable "db_name" {
  type = string
  description = "Database name"
}

variable "security_groups" { 
  type       = list(string)
  description = "List of security groups to attach to ECS Service"
}
