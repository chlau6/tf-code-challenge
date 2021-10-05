terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 13.0"
    }
  }
}

provider "aws" {
  region = var.region
}


