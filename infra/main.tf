###############################################################################
# Terraform Backend & Provider Configuration
###############################################################################

terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    # Backend values are supplied via *.conf files (-backend-config flag)
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

###############################################################################
# EC2 Instance
###############################################################################

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name        = "${var.project_name}-${terraform.workspace}"
    Environment = terraform.workspace
    ManagedBy   = "terraform"
  }
}
