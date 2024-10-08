terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
#   backend "s3" {
#     bucket = "fullcycle-terraform-remote-state"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#   }
}

provider "aws" {
  region = "us-east-1"
}