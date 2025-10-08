terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "django-devops-recipe-state-bucket"
    key            = "setup"
    region         = "us-east-1"
    dynamodb_table = "django-devops-recipe-lock-tbl"
    encrypt        = true
  }
}
provider "aws" {
  region = "us-east-1"

  # default_tags are useful for tagging all resources created for this project
  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project_name
      contact     = var.contact
      ManagedBy   = "Terraform/setup"
    }
  }
}

locals {
  prefix = var.project_name
}
