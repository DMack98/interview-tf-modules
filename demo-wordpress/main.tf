module "alb" {
  source = "git@github.com:cloudposse/terraform-aws-alb.git?ref=0.35.3"

  name      = "demo-wordpress"
  namespace = var.namespace

  label_order       = ["namespace", "name", "attributes", "environment"]
  label_key_case    = "lower"
  target_group_name = "demo-wordpress"

  vpc_id                = var.vpc_id
  subnet_ids            = var.public_subnets
  certificate_arn       = var.alb_certificate_arn
  http_enabled          = false
  https_enabled         = true
  access_logs_enabled   = false
  health_check_interval = 60
  health_check_matcher  = "200-400"
}


module "cluster" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-ecs.git?ref=v5.0.1"

  cluster_name = "demo-wordpress"
}

module "task_security_group" {
  source  = "cloudposse/security-group/aws"
  version = "0.4.0"

  enabled               = true
  create_before_destroy = true

  namespace  = var.namespace
  name       = "demo-wordpress"
  attributes = ["task"]

  vpc_id           = var.vpc_id
  allow_all_egress = true
  rule_matrix = [
    {
      source_security_group_ids = [module.alb.security_group_id]
      rules = [
        {
          key         = "web"
          type        = "ingress"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          description = "allow load balancer"
        }
      ]
    }
  ]
}


module "service" {
  source = "git@github.com:cloudposse/terraform-aws-ecs-web-app.git?ref=0.65.2"

  name           = "demo-wordpress"
  namespace      = var.namespace
  label_order    = ["namespace", "name", "attributes", "environment"]
  label_key_case = "lower"

  ecs_cluster_name = module.cluster.cluster_name

  region                         = var.region
  ecs_cluster_arn                = module.cluster.cluster_arn
  codepipeline_enabled           = false
  container_image                = "public.ecr.aws/docker/library/wordpress:${var.wordpress_version}"
  container_cpu                  = 1024
  container_memory               = 3072
  task_cpu                       = 1024
  task_memory                    = 3072
  ignore_changes_task_definition = false
  desired_count                  = 1
  launch_type                    = "FARGATE"
  container_environment = [
    {
      name  = "WORDPRESS_DB_HOST"
      value = var.db_host
    },
    {
      name  = "WORDPRESS_DB_USER"
      value = var.db_user
    },
    {
      name  = "WORDPRESS_DB_PASSWORD"
      value = var.db_password
    },
    {
      name  = "WORDPRESS_DB_NAME"
      value = var.db_name
    },
    {
      name  = "PHP_MEMORY_LIMIT"
      value = "512M"
    },
    {
      name  = "enabled"
      value = "true"
    },
    {
      name  = "ALLOW_EMPTY_PASSWORD"
      value = "yes"
    },
    {
      name  = "WORDPRESS_DEBUG"
      value = "1"
    },
    {
      name  = "WP_DEBUG_DISPLAY"
      value = "true"
    },
    {
      name  = "WP_DEBUG_LOG"
      value = "true"
    },
    {
      name  = "WORDPRESS_ENABLE_HTTPS"
      value = "yes"
    },
    {
      name  = "FORCE_SSL_ADMIN"
      value = "true"
    }
  ]
  health_check_grace_period_seconds       = 0
  alb_arn_suffix                          = module.alb.alb_arn_suffix
  alb_security_group                      = module.alb.security_group_id
  use_alb_security_group                  = true
  ecs_security_group_ids                  = concat(var.security_groups, [module.task_security_group.id])
  alb_ingress_enable_default_target_group = false
  alb_ingress_target_group_arn            = module.alb.default_target_group_arn
  vpc_id                                  = var.vpc_id
  ecs_private_subnet_ids                  = var.private_subnets

}
