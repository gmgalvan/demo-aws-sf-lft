data "aws_iam_policy_document" "demo_vpc_codebuild_inline_policy" {
  statement {
    actions = [

      "ec2:CreateVpc",
      "ec2:DeleteVpc",
      "ec2:DescribeVpcs",
      "ec2:ModifyVpcAttribute",
      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:DescribeSubnets",
      "ec2:ModifySubnetAttribute",
      "ec2:CreateInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:DescribeInternetGateways",
      "ec2:AttachInternetGateway",
      "ec2:DetachInternetGateway",
      "ec2:CreateNatGateway",
      "ec2:DescribeAddressesAttribute",
      "ec2:DeleteNatGateway",
      "ec2:DescribeNatGateways",
      "ec2:DescribeVpcAttribute",
      "ec2:AllocateAddress",
      "ec2:ReleaseAddress",
      "ec2:DescribeAddresses",
      "ec2:AssociateAddress",
      "ec2:DisassociateAddress",
      "ec2:CreateRouteTable",
      "ec2:DeleteRouteTable",
      "ec2:DescribeRouteTables",
      "ec2:CreateRoute",
      "ec2:DeleteRoute",
      "ec2:ReplaceRoute",
      "ec2:AssociateRouteTable",
      "ec2:DisassociateRouteTable",
      "ec2:ReplaceRouteTableAssociation",
      "ec2:CreateVpcEndpoint",
      "ec2:DeleteVpcEndpoint",
      "ec2:DescribeVpcEndpoints",
      "ec2:ModifyVpcEndpoint",
      "ec2:DescribePrefixLists",
      "ec2:CreateDhcpOptions",
      "ec2:DeleteDhcpOptions",
      "ec2:DescribeDhcpOptions",
      "ec2:AssociateDhcpOptions",
      "ec2:CreateFlowLogs",
      "ec2:DeleteFlowLogs",
      "ec2:DescribeFlowLogs",
      "ec2:CreateSecurityGroup",
      "ec2:DeleteSecurityGroup",
      "ec2:DescribeSecurityGroups",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:ModifySecurityGroupRules",
      "ec2:CreateNetworkAcl",
      "ec2:DeleteNetworkAcl",
      "ec2:DescribeNetworkAcls",
      "ec2:CreateNetworkAclEntry",
      "ec2:DeleteNetworkAclEntry",
      "ec2:ReplaceNetworkAclEntry",
      "ec2:ReplaceNetworkAclAssociation",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:DescribeTags",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeRegions"
    ]
    resources = ["*"]
  }


  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:DeleteLogGroup",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy",
      "logs:TagLogGroup",
      "logs:UntagLogGroup",
      "logs:ListTagsForResource"
    ]
    resources = [
      "arn:aws:logs:*:*:log-group:/aws/lambda/*",
      "arn:aws:logs:*:*:log-group:/aws/codebuild/*",
      "arn:aws:logs:*:*:log-group:/aws/vpc/*"
    ]
  }

  statement {
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:GetRole",
      "iam:PassRole",
      "iam:UpdateRole",
      "iam:ListRoles",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:GetRolePolicy",
      "iam:ListRolePolicies",
      "iam:List*",
      "iam:TagRole",
      "iam:UntagRole"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:GetRole",
      "iam:PassRole",
      "iam:UpdateRole",
      "iam:ListRoles",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:GetRolePolicy",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:TagRole",
      "iam:UntagRole"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    actions = [
      "iam:CreatePolicy",
      "iam:DeletePolicy",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:ListPolicyVersions",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicyVersion"
    ]
    resources = [
      "arn:aws:iam::*:policy/*lambda*",
      "arn:aws:iam::*:policy/*${var.project_prefix}*"
    ]
  }
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:DeleteLogGroup",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutRetentionPolicy",
      "logs:TagLogGroup",
      "logs:UntagLogGroup",
      "logs:ListTagsForResource"
    ]
    resources = [
      "arn:aws:logs:*:*:log-group:/aws/lambda/*",
      "arn:aws:logs:*:*:log-group:/aws/codebuild/*"
    ]
  }
  statement {
    actions = [
      "events:PutRule",
      "events:DeleteRule",
      "events:DescribeRule",
      "events:PutTargets",
      "events:RemoveTargets",
      "events:ListTargetsByRule",
      "events:TagResource",
      "events:UntagResource"
    ]
    resources = [
      "arn:aws:events:*:*:rule/*${var.project_prefix}*",
      "arn:aws:events:*:*:rule/*lambda*"
    ]
  }
  statement {
    actions = [
      "dynamodb:CreateTable",
      "dynamodb:DeleteTable",
      "dynamodb:DescribeTable",
      "dynamodb:UpdateTable",
      "dynamodb:ListTables",
      "dynamodb:TagResource",
      "dynamodb:UntagResource",
      "dynamodb:ListTagsOfResource"
    ]
    resources = [
      "arn:aws:dynamodb:*:*:table/*${var.project_prefix}*"
    ]
  }
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      "arn:aws:dynamodb:*:*:table/*terraform*lock*"
    ]
  }
  statement {
    actions = [
      "ec2:DescribeVpcs",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeNetworkInterfaces",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:AttachNetworkInterface",
      "ec2:DetachNetworkInterface"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:SetRepositoryPolicy",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:UploadLayerPart",
      "ecr:ListImages",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetRepositoryPolicy",
      "ecr:PutImage"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "tag:GetResources",
      "tag:TagResources",
      "tag:UntagResources"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "demo_vpc_codebuild_role" {
  name               = "${local.demo_prefix}-deploy-demo-vpc-codebuild-role"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume_role_policy.json

  tags = {
    Environment = local.environment
    Solution    = local.solution
    Tenant      = local.tenant
  }
}

resource "aws_iam_role_policy" "demo_vpc_codebuild_policy" {
  name   = "${local.pipeline_name}-demo-vpc-codebuild-role-policy"
  role   = aws_iam_role.demo_vpc_codebuild_role.id
  policy = data.aws_iam_policy_document.demo_vpc_codebuild_inline_policy.json
}


resource "aws_iam_role_policy" "demo_vpc_codebuild_base_codebuild_policy" {
  name   = "${local.pipeline_name}-base-codebuild-policy"
  role   = aws_iam_role.demo_vpc_codebuild_role.id
  policy = data.aws_iam_policy_document.base_policy_statements.json
}

resource "aws_iam_role_policy" "demo_vpc_codebuild_state_infra_s3_policy" {
  name   = "${local.pipeline_name}-base-state-infra-s3-policy"
  role   = aws_iam_role.demo_vpc_codebuild_role.id
  policy = data.aws_iam_policy_document.state_infra_s3_policy_statements.json
}

resource "aws_iam_role_policy" "demo_vpc_codebuild_s3_policy" {
  name   = "${local.pipeline_name}-base-s3-policy"
  role   = aws_iam_role.demo_vpc_codebuild_role.id
  policy = data.aws_iam_policy_document.s3_policy_statements.json
}


resource "aws_iam_role_policy" "demo_vpc_codebuild_ssm_policy" {
  name   = "${local.pipeline_name}-base-ssm-policy"
  role   = aws_iam_role.demo_vpc_codebuild_role.id
  policy = data.aws_iam_policy_document.ssm_policy_statements.json
}






