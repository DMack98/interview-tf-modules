output "alb_name" {
  description = "The ARN suffix of the ALB"
  value       = module.alb.alb_name
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = module.cluster.cluster_id
}

output "ecs_cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = module.cluster.cluster_arn
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.cluster.cluster_name
}

output "ecs_alb_service_task" {
  description = "All outputs from `module.ecs_alb_service_task`"
  value       = module.service.ecs_alb_service_task
}

output "ecs_exec_role_policy_id" {
  description = "The ECS service role policy ID, in the form of `role_name:role_policy_name`"
  value       = module.service.ecs_exec_role_policy_id
}

output "ecs_exec_role_policy_name" {
  description = "ECS service role name"
  value       = module.service.ecs_exec_role_policy_name
}

output "ecs_service_name" {
  description = "ECS Service name"
  value       = module.service.ecs_service_name
}
output "ecs_service_role_arn" {
  description = "ECS Service role ARN"
  value       = module.service.ecs_service_role_arn
}

output "ecs_task_exec_role_name" {
  description = "ECS Task role name"
  value       = module.service.ecs_task_exec_role_name
}

output "ecs_task_exec_role_arn" {
  description = "ECS Task exec role ARN"
  value       = module.service.ecs_task_exec_role_arn
}

output "ecs_task_role_name" {
  description = "ECS Task role name"
  value       = module.service.ecs_task_role_name
}

output "ecs_task_role_arn" {
  description = "ECS Task role ARN"
  value       = module.service.ecs_task_role_arn
}

output "ecs_task_role_id" {
  description = "ECS Task role id"
  value       = module.service.ecs_task_role_id
}

output "db_host" {
  description = "Environment variables"
  value       = var.db_host
}
