output "bastion_ip" {
  value = aws_instance.bastion.private_ip
}