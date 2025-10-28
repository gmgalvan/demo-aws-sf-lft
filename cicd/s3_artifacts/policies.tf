data "aws_iam_policy_document" "allow_access_codepipeline_demo_infra_policy" {
  statement {
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.pipeline_bucket_demo_artifacts.id}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.pipeline_bucket_demo_artifacts.id}/*"
    ]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["aws:kms"]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_allow_access_codepipeline_demo_infra_policy" {
  bucket = aws_s3_bucket.pipeline_bucket_demo_artifacts.id
  policy = data.aws_iam_policy_document.allow_access_codepipeline_demo_infra_policy.json
}

resource "aws_s3_bucket_lifecycle_configuration" "aws_s3_bucket_lifecycle_demo_infra_configuration" {
  bucket = aws_s3_bucket.pipeline_bucket_demo_artifacts.id

  rule {
    id     = "expire-objects-after-7-days"
    status = "Enabled"

    filter {
      prefix = ""
    }

    expiration {
      days = 10
    }
  }
}