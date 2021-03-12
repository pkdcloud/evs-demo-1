locals {
  env = {
    global = {
      aws_profile     = "envirosuite-mgmt"
      aws_region      = "ap-southeast-2"
      resource_prefix = "envirosuite"
    }
    mgmt-apse2-horizon-collection = {
      aws_profile = "envirosuite-mgmt"
      aws_region  = "ap-southeast-2"

      # General Configuration
      vpc_id                = "vpc-025fc94159aad37d5"
      allowed_ingress_cidrs = ["10.0.0.0/8"]
      subnet_ids            = ["subnet-08cc1be5002145809", "subnet-0453d1da319ccccc4", "subnet-0cdd033ac7c388e20"]
      tcagent_token         = "evs-apse2-nonprod-teamcity-token"
      sg_name               = "evs-horizon-collection-sg"

      # Autoscaling Configuration
      asg_name         = "evs-horizon-collection-asg"
      min_size         = 1
      max_size         = 4
      desired_capacity = 2

      # Launch Configuration
      lc_name       = "evs-horizon-collection-lc"
      image_id      = "ami-0b72132eb3104947d"
      instance_type = "t3.small"
      key_name      = "evs-ec2-keypair"
      user_data     = file("./scripts/collection_config.sh")
      root_block_device = [
        {
          volume_size = "50"
          volume_type = "gp2"
        },
      ]
    }
    mgmt-apse2-horizon-processing = {
      aws_profile = "envirosuite-mgmt"
      aws_region  = "ap-southeast-2"

      # General Configuration
      vpc_id                = "vpc-025fc94159aad37d5"
      allowed_ingress_cidrs = ["10.0.0.0/8"]
      subnet_ids            = ["subnet-08cc1be5002145809", "subnet-0453d1da319ccccc4", "subnet-0cdd033ac7c388e20"]
      tcagent_token         = "evs-apse2-nonprod-teamcity-token"
      sg_name               = "evs-horizon-processing-sg"

      # Autoscaling Configuration
      asg_name         = "evs-horizon-processing-asg"
      min_size         = 1
      max_size         = 4
      desired_capacity = 2

      # Launch Configuration
      lc_name       = "evs-horizon-processing-lc"
      image_id      = "ami-0b72132eb3104947d"
      instance_type = "t3.small"
      key_name      = "evs-ec2-keypair"
      user_data     = file("./scripts/processing_config.sh")
      root_block_device = [
        {
          volume_size = "50"
          volume_type = "gp2"
        },
      ]
    }
    mgmt-apse2-horizon-presentation = {
      aws_profile = "envirosuite-mgmt"
      aws_region  = "ap-southeast-2"

      # General Configuration
      vpc_id                = "vpc-025fc94159aad37d5"
      allowed_ingress_cidrs = ["10.0.0.0/8"]
      subnet_ids            = ["subnet-08cc1be5002145809", "subnet-0453d1da319ccccc4", "subnet-0cdd033ac7c388e20"]
      sg_name               = "evs-horizon-presentation-sg"

      # Autoscaling Configuration
      asg_name         = "evs-horizon-presentation-asg"
      min_size         = 1
      max_size         = 4
      desired_capacity = 2

      # Launch Configuration
      lc_name       = "evs-horizon-presentation-lc"
      image_id      = "ami-0b72132eb3104947d"
      instance_type = "t3.small"
      key_name      = "evs-ec2-keypair"
      user_data     = file("./scripts/presentation_config.sh")
      root_block_device = [
        {
          volume_size = "50"
          volume_type = "gp2"
        },
      ]
    }
    mgmt-apse2-horizon-storage = {
      aws_profile = "envirosuite-mgmt"
      aws_region  = "ap-southeast-2"

      # General Configuration
      vpc_id                = "vpc-025fc94159aad37d5"
      allowed_ingress_cidrs = ["10.0.0.0/8"]
      subnet_ids            = ["subnet-08cc1be5002145809", "subnet-0453d1da319ccccc4", "subnet-0cdd033ac7c388e20"]
      sg_name               = "evs-horizon-storage-sg"

      # Autoscaling Configuration
      asg_name         = "evs-horizon-storage-asg"
      min_size         = 1
      max_size         = 4
      desired_capacity = 2

      # Launch Configuration
      lc_name       = "evs-horizon-storage-lc"
      image_id      = "ami-0b72132eb3104947d"
      instance_type = "t3.small"
      key_name      = "evs-ec2-keypair"
      user_data     = file("./scripts/storage_config.sh")
      root_block_device = [
        {
          volume_size = "50"
          volume_type = "gp2"
        },
      ]
    }
    mgmt-apse2-horizon-reporting = {
      aws_profile = "envirosuite-mgmt"
      aws_region  = "ap-southeast-2"

      # General Configuration
      vpc_id                = "vpc-025fc94159aad37d5"
      allowed_ingress_cidrs = ["10.0.0.0/8"]
      subnet_ids            = ["subnet-08cc1be5002145809", "subnet-0453d1da319ccccc4", "subnet-0cdd033ac7c388e20"]
      tcagent_token         = "evs-apse2-nonprod-teamcity-token"
      sg_name               = "evs-apse2-horizon-sg"
      # Autoscaling Configuration
      asg_name         = "evs-horizon-reporting-asg"
      min_size         = 1
      max_size         = 4
      desired_capacity = 2

      # Launch Configuration
      lc_name       = "evs-horizon-reporting-lc"
      image_id      = "ami-0b72132eb3104947d"
      instance_type = "t3.small"
      key_name      = "evs-ec2-keypair"
      user_data     = file("./scripts/reporting_config.sh")
      root_block_device = [
        {
          volume_size = "50"
          volume_type = "gp2"
        },
      ]
    }
  }

  workspace = local.env[terraform.workspace]
}
