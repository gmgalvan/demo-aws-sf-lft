#####################################
# Project Pipeline and Environment Details
#####################################
data "aws_ssm_parameter" "tenant" {
  name = "/${var.project_prefix}/general/project_details/tenant"
}

data "aws_ssm_parameter" "project_name" {
  name = "/${var.project_prefix}/general/project_details/project_name"
}

data "aws_ssm_parameter" "solution" {
  name = "/${var.project_prefix}/general/project_details/solution"
}

data "aws_ssm_parameter" "pipeline_demo_artifacts_bucket_name" {
  name = "/${var.project_prefix}/dev/s3/pipeline_demo_artifacts_bucket_name"
}