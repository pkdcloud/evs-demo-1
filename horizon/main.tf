# TC Agents - Terraform

module "asg" {
  source = "../_modules/asg"
  name   = local.workspace["asg_name"]

  # Launch configuration
  lc_name           = local.workspace["lc_name"]
  image_id          = local.workspace["image_id"]
  instance_type     = local.workspace["instance_type"]
  key_name          = local.workspace["key_name"]
  security_groups   = [aws_security_group.sg.id]
  root_block_device = local.workspace["root_block_device"]
  user_data         = local.workspace["user_data"]

  # Auto scaling group
  asg_name                  = local.workspace["asg_name"]
  vpc_zone_identifier       = local.workspace["subnet_ids"]
  health_check_type         = "EC2"
  min_size                  = local.workspace["min_size"]
  max_size                  = local.workspace["max_size"]
  desired_capacity          = local.workspace["desired_capacity"]
  wait_for_capacity_timeout = 0

  tags_as_map = {
    repository = "evs-aws-teamcity-agents/horizon"
    workspace  = terraform.workspace
  }
}

# Security group

resource "aws_security_group" "sg" {
  name        = local.workspace["sg_name"]
  description = "Allow TLS inbound traffic"
  vpc_id      = local.workspace["vpc_id"]

  ingress {
    description = "Horizon Ports"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = local.workspace["allowed_ingress_cidrs"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "evs-apse2-horizon-sg"
    repository = "evs-aws-teamcity-agents/horizon"
    workspace  = terraform.workspace
  }
}
