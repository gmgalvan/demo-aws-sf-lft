locals {
  # S3 bucket name for pipeline demo artifacts retrieved from SSM parameter
  pipeline_demo_artifacts_bucket_name = data.aws_ssm_parameter.pipeline_demo_artifacts_bucket_name.value

  # Core project parameters retrieved from SSM
  project_name = data.aws_ssm_parameter.project_name.value
  tenant       = data.aws_ssm_parameter.tenant.value
  solution     = data.aws_ssm_parameter.solution.value
}