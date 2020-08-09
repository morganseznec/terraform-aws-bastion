output "private_ip" {
  value       = aws_instance.bastion.private_ip
  description = "The Bastion private IP address"
}

output "public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "The Bastion public IP address"
}

output "name" {
  value       = "ec2-${var.region_short[data.aws_region.region.name]}-${var.availability_zone}-${var.env}-${var.project}-bastion"
  description = "The bastion name (in the AWS console)"
}

output "id" {
  value       = aws_instance.bastion.id
  description = "The instance ID of the bastion"
}