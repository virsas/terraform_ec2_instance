# terraform_ec2

Terraform module to create EC2 instance.

## Dependencies

VPC <https://github.com/virsas/terraform_vpc>
VPC SUBNET <https://github.com/virsas/terraform_vpc_subnet>
VPC SG <https://github.com/virsas/terraform_vpc_sg>
SSHKEY <https://github.com/virsas/terraform_ec2_sshkey>
IAM ROLE <https://github.com/virsas/terraform_iam_role>

## Terraform example

``` terraform
##################
# EC2 Variable
##################
variable "ec2_ecs_api1" { 
  default = {
    # Name of the instance
    name = "api1"
    # Credit option for CPU usage. Valid values: standard, unlimited
    credits = "standard"
    # Instance size
    type = "t4g.small"
    # OS AMI
    image = "ami-07e30a3659a490be7"
    # Private IP address from the subnet allocated to this instance
    private_ip = "10.0.0.4"
    # Allow public IP address (true/false)
    public_ip = "false"
    # Type of block device mounted to the instance
    volume_type = "gp2"
    # Size of the block device
    volume_size = "30"
    # Enable or disable encryption
    volume_encrypt = true
    # Enable deletion of block device on instance termination
    volume_delete = true
  } 
}

##################
# EC2 Instance
##################
module "ec2_ecs_api1" {
  source          = "github.com/virsas/terraform_ec2"

  instance        = var.ec2_ecs_api1

  # initial ssh key used to access this instance
  key             = module.ec2_sshkey_user1.name

  # list of security groups
  security_groups = [ module.vpc_sg_admin.id, module.vpc_sg_api.id ]
  # VPC subnet membership. Must be the very same block as the IP configuration of the private_ip
  subnet          = module.vpc_subnet_api_a.id
}
```
