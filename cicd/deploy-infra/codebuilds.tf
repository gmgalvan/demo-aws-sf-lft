module "codebuild_demo_vpc" {
  source         = "../modules/codebuild-terraform-workflow"
  component_name = replace("${local.demo_prefix}-${local.demo_vpc_component_name}-infra-deploy", "_", "-")
  codebuild_role = aws_iam_role.demo_vpc_codebuild_role.arn

  project_name = local.project_name

  tf_plan_build_spec  = "infra/vpc-demo/buildspecs/dev/buildspec_plan.yml"
  tf_apply_build_spec = "infra/vpc-demo/buildspecs/dev/buildspec_apply.yml"

  aws_region = local.aws_region

  tags = {
    Solution    = local.project_name
    Tenant      = local.tenant
    Environment = local.environment
  }
}