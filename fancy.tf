variable "number_of_instances" {
  description = "Number of instances to create and attach to Consumer ELB"
  default     = 2
}

module "ec2_instances" {
  source         = "app.terraform.io/hashidemos/consumer-ec2-instance/aws"
  version        = "1.25.0"
  name           = "${var.name}-ec2"
  instance_count = var.number_of_instances
}

output "ec2_instance_ids" {
  value = module.ec2_instances.id
}

module "elb" {
  source      = "app.terraform.io/hashidemos/consumer-elb/aws"
  version     = "1.28.0"
  name        = "${var.name}-elb"
  environment = var.environment
  # ELB attachments
  number_of_instances = var.number_of_instances
  instances           = module.ec2_instances.id
}

output "fancy-app-url" {
  value = module.elb.dns_name
}