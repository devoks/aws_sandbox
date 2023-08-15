terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["/Users/devavrat.oka/.aws/config"]
  shared_credentials_files = ["/Users/devavrat.oka/.aws/credentials"]
  profile                  = "default"
}

provider "aws" {
  alias = "secondaccount"
  assume_role {
    role_arn = "arn:aws:iam::137211703014:role/OrganizationAccountAccessRole"
  }
}

provider "aws" {
  alias = "thirdaccount"
  assume_role {
    role_arn = "arn:aws:iam::239400404210:role/OrganizationAccountAccessRole"
  }
}

