data "aws_iam_policy_document" "pipeline_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "pipeline_inline_policy" {
  # IAM PassRole permissions
  statement {
    actions = ["iam:PassRole"]
    resources = [
      "arn:aws:iam::*:role/*codebuild*",
      "arn:aws:iam::*:role/*lambda*",
      "arn:aws:iam::*:role/*pipeline*"
    ]
    condition {
      test     = "StringEqualsIfExists"
      variable = "iam:PassedToService"
      values = [
        "codebuild.amazonaws.com",
        "lambda.amazonaws.com",
        "codepipeline.amazonaws.com"
      ]
    }
  }

  # CodeCommit permissions
  statement {
    actions = [
      "codecommit:CancelUploadArchive",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetRepository",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:UploadArchive"
    ]
    resources = [
      "arn:aws:codecommit:*:*:*softserve*",
      "arn:aws:codecommit:*:*:*demo*"
    ]
  }

  # CodeBuild permissions
  statement {
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codebuild:BatchGetBuildBatches",
      "codebuild:StartBuildBatch"
    ]
    resources = [
      "arn:aws:codebuild:*:*:project/*softserve*",
      "arn:aws:codebuild:*:*:project/*demo*"
    ]
  }

  # ECR permissions for Docker images
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:GetAuthorizationToken",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = [
      "arn:aws:ecr:*:*:repository/*softserve*",
      "arn:aws:ecr:*:*:repository/*demo*",
      "*" # GetAuthorizationToken requires *
    ]
  }

  # Lambda permissions
  statement {
    actions = [
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration",
      "lambda:GetFunction",
      "lambda:ListFunctions",
      "lambda:PublishVersion",
      "lambda:CreateAlias",
      "lambda:UpdateAlias",
      "lambda:InvokeFunction"
    ]
    resources = [
      "arn:aws:lambda:*:*:function:*softserve*",
      "arn:aws:lambda:*:*:function:*demo*"
    ]
  }

  # Parameter Store permissions
  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    resources = [
      "arn:aws:ssm:*:*:parameter/demo/softserve/*"
    ]
  }

  # S3 permissions for pipeline artifacts
  statement {
    actions = [
      "s3:GetBucketVersioning",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::*codepipeline*",
      "arn:aws:s3:::*codepipeline*/*",
      "arn:aws:s3:::*pipeline-artifact*",
      "arn:aws:s3:::*pipeline-artifact*/*"
    ]
  }

  # EventBridge permissions
  statement {
    actions = [
      "events:PutRule",
      "events:PutTargets",
      "events:DeleteRule",
      "events:RemoveTargets",
      "events:DescribeRule"
    ]
    resources = [
      "arn:aws:events:*:*:rule/*softserve*",
      "arn:aws:events:*:*:rule/*demo*"
    ]
  }

  # DynamoDB permissions
  statement {
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan"
    ]
    resources = [
      "arn:aws:dynamodb:*:*:table/*softserve*",
      "arn:aws:dynamodb:*:*:table/*demo*"
    ]
  }

  # CloudWatch Logs permissions
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "arn:aws:logs:*:*:log-group:/aws/codebuild/*",
      "arn:aws:logs:*:*:log-group:/aws/lambda/*"
    ]
  }

  # CodeStar connections (for GitHub integration)
  statement {
    actions = [
      "codestar-connections:UseConnection"
    ]
    resources = [
      "${local.codestar_connection_arn}"
    ]
  }

  statement {
    actions = [
      "cloudformation:CreateStack",
      "cloudformation:UpdateStack",
      "cloudformation:DeleteStack",
      "cloudformation:DescribeStacks",
      "cloudformation:DescribeStackEvents",
      "cloudformation:DescribeStackResources",
      "cloudformation:GetTemplate",
      "cloudformation:ValidateTemplate"
    ]
    resources = [
      "arn:aws:cloudformation:*:*:stack/*softserve*/*",
      "arn:aws:cloudformation:*:*:stack/*demo*/*"
    ]
  }
}

resource "aws_iam_role" "demo_codepipeline_service_role" {
  name               = "${local.demo_prefix}-deploy-codepipeline-base-svc-role"
  assume_role_policy = data.aws_iam_policy_document.pipeline_assume_role_policy.json

  tags = {
    Environment = local.environment
    Solution    = local.solution
    Tenant      = local.tenant
  }
}

resource "aws_iam_role_policy" "demo_codepipeline_policy" {
  name   = "${local.pipeline_name}-codepipeline-role-policy"
  role   = aws_iam_role.demo_codepipeline_service_role.id
  policy = data.aws_iam_policy_document.pipeline_inline_policy.json
}
