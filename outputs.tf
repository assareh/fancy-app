output "subnet_id" {
  value = nonsensitive(data.aws_subnet.this.id)
}