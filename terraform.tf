terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.36.1"
    }
  }
  required_version = ">= 1.0"
}
