provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      lab = "observability"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "local_file" "thanos_s3_config" {
  filename = var.s3_yaml_path
  content  = templatefile("../observability/thanos/s3.yml.tpl", {
    bucket_name    = var.bucket_name
    aws_region     = var.aws_region
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
  })
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}