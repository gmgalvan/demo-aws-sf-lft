#####################################
# AWS Configuration
#####################################
data "aws_ssm_parameter" "aws_region" {
  name = "/${var.project_prefix}/general/project_details/aws_region"
}

data "aws_caller_identity" "current" {}


#####################################
# Project Pipeline and Environment Details
#####################################
data "aws_ssm_parameter" "tenant" {
  name = "/${var.project_prefix}/general/project_details/tenant"
}

data "aws_ssm_parameter" "dev_env" {
  name = "/${var.project_prefix}/general/project_details/dev_env"
}

data "aws_ssm_parameter" "solution" {
  name = "/${var.project_prefix}/general/project_details/solution"
}

data "aws_ssm_parameter" "project_name" {
  name = "/${var.project_prefix}/general/project_details/project_name"
}

data "aws_ssm_parameter" "s3_bucket_artifact_id" {
  name = "/${var.project_prefix}/dev/s3/pipeline_demo_artifacts_bucket_name"
}


#####################################
# Code and Repository Details
#####################################
data "aws_ssm_parameter" "codestar_connection_arn" {
  name = "/${var.project_prefix}/general/codepipeline/codestar_connection_arn"
}

data "aws_ssm_parameter" "repository_name" {
  name = "/${var.project_prefix}/general/project_details/repository_name"
}

data "aws_ssm_parameter" "branch_name" {
  name = "/${var.project_prefix}/${local.environment}/codepipeline/deploy_infra_pipeline_branch_name"
}

#####################################
# Component Names
#####################################

data "aws_ssm_parameter" "demo_vpc_component_name" {
  name = "/${var.project_prefix}/general/codepipeline/demo_vpc_component_name"
}