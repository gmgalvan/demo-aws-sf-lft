terraform {
  required_version = "~> 1.13.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.12.0"
    }
  }

  backend "s3" {
    bucket         = "demo-infra-tf-state-backend"
    key            = "dev/base/parameters/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "demo-terraform-state-lock"
    encrypt        = true
  }
}