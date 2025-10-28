data "aws_caller_identity" "current" {}

variable "codebuild_role" {
  type = string
}

variable "project_name" {
  type = string
}

variable "component_name" {
  type = string
}

variable "tf_plan_build_spec" {
  type = string
}

variable "tf_apply_build_spec" {
  type = string
}

variable "codebuild_vpc_config" {
  description = "VPC configuration for the CodeBuild project"
  type = object({
    vpc_id             = string
    subnets            = list(string)
    security_group_ids = list(string)
  })
  default = null
}

variable "tags" {
  description = "Tags to apply to the CodeBuild project"
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "concurrent_build_limit" {
  description = "The number of concurrent builds allowed for the project"
  type        = string
  default     = "1"
}

variable "encryption_key" {
  description = "The KMS key to use for encrypting the artifacts"
  type        = string
  default     = null

}