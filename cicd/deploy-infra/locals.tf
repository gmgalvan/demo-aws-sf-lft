locals {
  # ==========================================
  # Project Configuration
  # ==========================================
  project_name = data.aws_ssm_parameter.project_name.value
  tenant       = data.aws_ssm_parameter.tenant.value
  environment  = data.aws_ssm_parameter.dev_env.value
  solution     = data.aws_ssm_parameter.solution.value

  # ==========================================
  # AWS Configuration
  # ==========================================
  aws_region = data.aws_ssm_parameter.aws_region.value
  account_id = data.aws_caller_identity.current.account_id

  # ==========================================
  # Naming Conventions
  # ==========================================
  demo_prefix      = "${lower(data.aws_ssm_parameter.project_name.value)}-${lower(data.aws_ssm_parameter.tenant.value)}-${lower(data.aws_ssm_parameter.dev_env.value)}"
  demo_prefix_path = "${data.aws_ssm_parameter.project_name.value}/${data.aws_ssm_parameter.tenant.value}/${data.aws_ssm_parameter.dev_env.value}"

  # ==========================================
  # Pipeline Configuration
  # ==========================================
  pipeline_name           = "${local.demo_prefix}-deploy-infra-demo-codepipeline"
  s3_bucket_artifact_id   = data.aws_ssm_parameter.s3_bucket_artifact_id.value
  codestar_connection_arn = data.aws_ssm_parameter.codestar_connection_arn.value

  # ==========================================
  # Repository Configuration
  # ==========================================
  repository_name = data.aws_ssm_parameter.repository_name.value
  branch_name     = data.aws_ssm_parameter.branch_name.value

  # ==========================================
  # Component Names
  # ==========================================e
  demo_vpc_component_name = data.aws_ssm_parameter.demo_vpc_component_name.value
}