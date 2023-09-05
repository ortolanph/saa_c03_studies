// TODO: Define an autoscaling group

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
  }
}

provider "aws" {
  profile = "saa_c03_studies"
  region  = "eu-west-1"
}
