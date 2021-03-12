provider "aws" {
  version = "3.14.1"
  profile = local.workspace["aws_profile"]
  region  = local.workspace["aws_region"]
}
