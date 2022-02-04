terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.46.0"
    }
  }
  // TO DO: change $yourname by your own name!
  backend "s3" {
    bucket = "better-infrastructure-management-with-terraform"
    key    = "state_manipulation/bert/terraform.tfstate"
    region = "eu-west-1"
    profile = "academy"
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-1"
  profile = "academy"
}

