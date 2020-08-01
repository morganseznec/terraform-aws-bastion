# Get current Region
data "aws_region" "region" {} 

# Get latest Amazon AMI
data "aws_ami" "amazon" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Get VPC
data "aws_vpc" "vpc" {
  id = var.vpc_id
}

# Create a bastion subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr != "" ? var.public_subnet_cidr : cidrsubnet(data.aws_vpc.vpc.cidr_block, 12, 15)
  map_public_ip_on_launch = true
  availability_zone       = join("", [data.aws_region.region.name, var.availability_zone])

  tags = {
    Name = "subnet-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}-bastion"
  }
}


# Create security group for the Bastion instance
resource "aws_security_group" "sg_bastion" {
  vpc_id = var.vpc_id
  name   = "security-group-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}-bastion"
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = var.allow_from
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security-group-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}-bastion"
  }
}

data "template_file" "user_data" {
  template = var.user_data_file != "" ? file(var.user_data_file) : file("${path.module}/user-data.yaml")
  vars = {
    ssh_port = var.ssh_port
  }
}

# Create bastion instance
resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon.id
  instance_type = var.instance_type

  associate_public_ip_address = var.associate_public_ip_address

  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.sg_bastion.id]

  key_name = var.key_name

  user_data = data.template_file.user_data.rendered

  private_ip = cidrhost(var.public_subnet_cidr != "" ? var.public_subnet_cidr : cidrsubnet(data.aws_vpc.vpc.cidr_block, 12, 15), 5)

  tags = {
    Name = "ec2-${var.region_short[data.aws_region.region.name]}-${var.availability_zone}-${var.env}-${var.project}-bastion"
  }
}