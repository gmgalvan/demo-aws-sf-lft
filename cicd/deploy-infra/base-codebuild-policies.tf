data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "state_infra_s3_policy_statements" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [
      "arn:aws:s3:::${local.s3_bucket_artifact_id}*",
      "arn:aws:s3:::*-infra-tf-state-backend*"
    ]
  }
}


data "aws_iam_policy_document" "s3_policy_statements" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:List*",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${local.s3_bucket_artifact_id}*",
      "arn:aws:s3:::*-infra-tf-state-backend*"
    ]
  }
}


data "aws_iam_policy_document" "ssm_policy_statements" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:GetParametersByPath",
      "ssm:PutParameter",
      "ssm:AddTagsToResource",
      "ssm:DeleteParameter",
      "ssm:ListTagsForResource",
      "ssm:RemoveTagsFromResource"
    ]
    resources = [
      "arn:aws:ssm:${local.aws_region}:${local.account_id}:parameter/${local.project_name}/${local.tenant}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:DescribeParameters"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "base_policy_statements" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:ListTagsLogGroup",
      "logs:TagResource",
      "logs:DeleteLogGroup"
    ]
    resources = [
      "arn:aws:logs:${local.aws_region}:${local.account_id}:log-group:*",
      "arn:aws:logs:${local.aws_region}:${local.account_id}:log-group::log-stream"
    ]
  }
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [
      "arn:aws:s3:::${local.pipeline_name}-codepipeline-${local.aws_region}*"
    ]
  }
  statement {
    actions = [
      "codebuild:CreateReportGroup",
      "codebuild:CreateReport",
      "codebuild:UpdateReport",
      "codebuild:BatchPutTestCases",
      "codebuild:BatchPutCodeCoverages"
    ]
    resources = [
      "arn:aws:codebuild:${local.aws_region}:${local.account_id}:report-group/*"
    ]
  }
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::softserve-demo-infra-tf-state-backend*"
    ]
  }
  statement {
    actions = [
      "ssm:GetParametersByPath",
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:PutParameter",
      "ssm:AddTagsToResource",
      "ssm:ListTagsForResource",
      "ssm:DeleteParameter"
    ]
    resources = [
      "arn:aws:ssm:${local.aws_region}:${local.account_id}:parameter/*"
    ]
  }
  statement {
    actions = [
      "ssm:DescribeParameters"
    ]
    resources = [
      "arn:aws:ssm:${local.aws_region}:${local.account_id}:*"
    ]
  }
}


data "aws_iam_policy_document" "secret_manager_policy_statements" {
  statement {
    actions = [
      "secretsmanager:DescribeSecret",
      "secretsmanager:PutSecretValue",
      "secretsmanager:CreateSecret",
      "secretsmanager:DeleteSecret",
      "secretsmanager:CancelRotateSecret",
      "secretsmanager:ListSecretVersionIds",
      "secretsmanager:BatchGetSecretValue",
      "secretsmanager:UpdateSecret",
      "secretsmanager:ListSecrets",
      "secretsmanager:GetRandomPassword",
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:StopReplicationToReplica",
      "secretsmanager:ReplicateSecretToRegions",
      "secretsmanager:RestoreSecret",
      "secretsmanager:RotateSecret",
      "secretsmanager:UpdateSecretVersionStage",
    ]
    resources = [
      "arn:aws:secretsmanager:${local.aws_region}:${local.account_id}:secret:/${local.project_name}/${local.tenant}/*"
    ]
  }
  statement {
    actions = [
      "secretsmanager:ListSecrets",
      "secretsmanager:DescribeSecret",
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue"
    ]
    resources = ["*"]
  }
}