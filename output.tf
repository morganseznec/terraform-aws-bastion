output "private_ip" {
  value       = aws_instance.bastion.private_ip
  description = "The Bastion private IP address"
}

output "public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "The Bastion public IP address"
}

output "name" {
  value       = "ec2-${var.region_short[var.region]}-${var.availability_zone}-${var.env}-${var.project}-bastion"
  description = "The bastion name (in the AWS console)"
}