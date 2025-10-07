variable "project_name" {
  type    = string
  default = "devops-django-tf-ecs-efs"

}

variable "contact" {
  description = "Contact email for the project"
  type        = string
  default     = "admin@example.com"

}

variable "tf_state_bucket" {
  description = "The name of the S3 bucket to store the terraform state"
  type        = string
  default     = "django-devops-recipe-state-bucket"

}

variable "tf_state_lock_table" {
  description = "The name of the DynamoDB table to lock the terraform state"
  type        = string
  default     = "django-devops-recipe-lock-tbl"

}

variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"

}

