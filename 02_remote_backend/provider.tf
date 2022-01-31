terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.46.0"
    }
  }
  backend "s3" {
    // TO DO: configure this correctly after setting up the remote backend
    bucket = "better-infrastructure-management-with-terraform-72"
    key = "bert_state" 
    region  = "eu-west-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-west-3"
  profile = "academy"

}


