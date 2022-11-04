output "instance_id" {
  value = { for k, v in aws_instance.example : k => v.id }
}

output "subnet_id" {
  value = nonsensitive(data.aws_subnet.this.id)
}
