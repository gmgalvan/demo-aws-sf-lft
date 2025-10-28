module "cloudwatch_logs_plan" {
  source         = "../cloudwatch/"
  component_name = var.component_name
  project_name   = var.project_name
  tf_step        = "plan"
}

module "cloudwatch_logs_apply" {
  source         = "../cloudwatch/"
  component_name = var.component_name
  project_name   = var.project_name
  tf_step        = "apply"
}

resource "aws_codebuild_project" "this_plan" {
  depends_on = [var.codebuild_role]

  artifacts {
    encryption_disabled    = "false"
    name                   = "${var.component_name}-plan"
    override_artifact_name = "false"
    packaging              = "NONE"
    type                   = "CODEPIPELINE"
  }

  badge_enabled = "false"
  build_timeout = "60"

  cache {
    type = "NO_CACHE"
  }

  concurrent_build_limit = var.concurrent_build_limit
  encryption_key         = coalesce(var.encryption_key, "arn:aws:kms:${var.aws_region}:${data.aws_caller_identity.current.account_id}:alias/aws/s3")

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = "false"
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      status     = "ENABLED"
      group_name = module.cloudwatch_logs_plan.log_name
    }

    s3_logs {
      encryption_disabled = "false"
      status              = "DISABLED"
    }
  }

  name               = "${var.component_name}-plan"
  project_visibility = "PRIVATE"
  queued_timeout     = "480"

  service_role = var.codebuild_role

  source {
    buildspec           = var.tf_plan_build_spec
    git_clone_depth     = "0"
    insecure_ssl        = "false"
    report_build_status = "false"
    type                = "CODEPIPELINE"
  }

  dynamic "vpc_config" {
    for_each = var.codebuild_vpc_config != null ? [var.codebuild_vpc_config] : []

    content {
      security_group_ids = var.codebuild_vpc_config.security_group_ids
      subnets            = var.codebuild_vpc_config.subnets
      vpc_id             = var.codebuild_vpc_config.vpc_id
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_codebuild_project" "this_apply" {
  depends_on = [var.codebuild_role]

  artifacts {
    encryption_disabled    = "false"
    name                   = "${var.component_name}-apply"
    override_artifact_name = "false"
    packaging              = "NONE"
    type                   = "CODEPIPELINE"
  }

  badge_enabled = "false"
  build_timeout = "60"

  cache {
    type = "NO_CACHE"
  }

  concurrent_build_limit = var.concurrent_build_limit
  encryption_key         = coalesce(var.encryption_key, "arn:aws:kms:${var.aws_region}:${data.aws_caller_identity.current.account_id}:alias/aws/s3")

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = "false"
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      status     = "ENABLED"
      group_name = module.cloudwatch_logs_apply.log_name
    }

    s3_logs {
      encryption_disabled = "false"
      status              = "DISABLED"
    }
  }

  name               = "${var.component_name}-apply"
  project_visibility = "PRIVATE"
  queued_timeout     = "480"
  service_role       = var.codebuild_role

  source {
    buildspec           = var.tf_apply_build_spec
    git_clone_depth     = "0"
    insecure_ssl        = "false"
    report_build_status = "false"
    type                = "CODEPIPELINE"
  }

  dynamic "vpc_config" {
    for_each = var.codebuild_vpc_config != null ? [var.codebuild_vpc_config] : []

    content {
      security_group_ids = var.codebuild_vpc_config.security_group_ids
      subnets            = var.codebuild_vpc_config.subnets
      vpc_id             = var.codebuild_vpc_config.vpc_id
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}