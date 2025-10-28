resource "aws_s3_bucket" "pipeline_bucket_demo_artifacts" {
  bucket = local.pipeline_demo_artifacts_bucket_name
}