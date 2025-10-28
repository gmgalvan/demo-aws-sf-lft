variable "project_prefix" {
  type        = string
  description = "The name of the project"
  default     = "demo/softserve"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}



variable "solution" {
  description = "Sol value (solution identifier)"
  type        = string
}

variable "tenant" {
  description = "Ten value (tenant identifier)"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "The environment to deploy resources in"
  type        = string
}

variable "aws_vpc_cidr" {
  description = "The CIDR block for the VPC to be created"
  type        = string
}

variable "vpc_public_subnet_count" {
  description = "Number of public subnets to create"
  type        = string
}

variable "vpc_private_subnet_count" {
  description = "Number of private subnets to create"
  type        = string
}