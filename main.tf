provider "aws" {
  region = var.region
}

resource "aws_instance" "instance" {
	key_name = var.key

	instance_type = var.instance.type
	ami = var.instance.image

  vpc_security_group_ids = var.security_groups
  subnet_id = var.subnet
  private_ip = var.instance.private_ip
  associate_public_ip_address = var.instance.public_ip

  root_block_device {
    volume_type = var.instance.volume_type
    volume_size = var.instance.volume_size
    encrypted = var.instance.volume_encrypt
    delete_on_termination = var.instance.volume_delete
  }
  
  credit_specification {
    cpu_credits = var.instance.credits
  }

  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 1
    http_tokens = "required"
  }
	
  tags = {
		Name = var.instance.name
	}
}