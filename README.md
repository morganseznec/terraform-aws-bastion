# terraform-aws-bastion

Terraform Module for provisioning a Bastion Host in an AWS VPC.

Features:

* Automatically creates a public subnet and a security group
* Automatically creates an ec2 bastion instance

## Usage

### Example

```hcl
module "example_bastion" {
  source                         = "github.com/morganseznec/terraform-aws-bastion"
  project                        = "myproject"
  vpc_id                         = aws_vpc.vpc.id
  public_subnet_cidr             = "192.168.254.0/30"
  key_name                       = "deployer"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.28 |
| template | ~> 2.1 |
| aws | ~> 2.69 |

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project | Project name | `string` | `""` | yes |
| availability_zone | Availability zone (a, b, c, d) | `string` | `"a"` | no |
| vpc_id | VPC ID | `string` | `""` | yes |
| ssh_port | SSH port number | `number` | `22` | no |
| allow_from | Allowed IP Addresses | `list(string)` | `["0.0.0.0/0"]` | no |
| instance_type | Instance type | `string` | `t3a.nano` | no |
| user_data_file | User-data file path used by Cloud-init | `string` | `""` | no |
| public_subnet_cidr | Public subnet cidr | `string` | `"10.0.0.0/24"` | no |
| associate_public_ip_address | Associate a public IP address to the bastion host | `bool` | `true` | no |
| key_name | SSH Private key name | `string` | `""` | yes |
| env | Environment (t (test), s (staging), p (prod)) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| private_ip | Private IP of the bastion host |
| public_ip | Public IP of the bastion host |
| name | name of the Bastion (in the AWS console) |

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
