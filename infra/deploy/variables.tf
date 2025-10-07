variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "devops-django-tf-ecs-efs"

}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "devops-django-tf-ecs-efs"

}

variable "contact" {
  description = "Contact email for the project"
  type        = string
  default     = "me@example.com"

}

variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"

}
