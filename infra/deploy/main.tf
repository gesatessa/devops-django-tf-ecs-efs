terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "django-devops-recipe-state-bucket"
    key            = "deploy"
    region         = "us-east-1"
    dynamodb_table = "django-devops-recipe-lock-tbl"
    encrypt        = true
    workspace_key_prefix = "tf-state-deploy"
    
  }
}

provider "aws" {
  region = var.aws_region

  # default_tags are useful for tagging all resources created for this project
  default_tags {
    tags = {
      Environment = terraform.workspace
      Project     = var.project_name
      contact     = var.contact
      ManagedBy   = "Terraform/deploy"
    }
  }
  
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}

# data "aws_regions" "available" {}
data "aws_region" "current" {}