provider "aws" {
  region = var.region_name
}
terraform {
  required_version = "~> 1.2.2"
  backend "s3" {}

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.20.1"
    }
  }
}