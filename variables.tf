variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "allow_from" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "instance_type" {
  type    = string
  default = "t3a.nano"
}

variable "user_data_file" {
  type    = string
  default = ""
}

variable "availability_zone" {
  type = string
  default = "a"
}

variable "public_subnet_cidr" {
  type    = string
  default = ""
}

variable "associate_public_ip_address" {
  type    = bool
  default = true
}

variable "env" {
  type    = string
  default = "p"
}

variable "key_name" {
  type = string
}

variable "region_short" {
  type = map(string)
  default = {
    eu-central-1   = "ec1"
    eu-north-1     = "en1"
    eu-west-1      = "ew1"
    eu-west-2      = "ew2"
    eu-west-3      = "ew3"
    us-east-1      = "ue1"
    us-east-2      = "ue2"
    us-west-1      = "uw1"
    us-west-2      = "uw2"
    sa-east-1      = "se1"
    ap-northeast-1 = "an1"
    ap-northeast-2 = "an2"
    ap-south-1     = "as1"
    ap-southeast-1 = "ase1"
    ap-southeast-2 = "ase2"
    ca-central-1   = "cc1"
  }
}