module "my-fancy-service" {
  source  = "app.terraform.io/hashidemos/ecs-service/aws"
  version = "1.0.4"

  name        = var.name
  environment = var.environment
  subnet_id   = lookup(local.subnets, var.environment, "fail")
  vpc_id      = local.vpc_id

  docker_image = "nginxdemos/hello:latest"
}

output "url" {
  value = module.my-fancy-service.alb_hostname
}