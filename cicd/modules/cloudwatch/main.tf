resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/codebuild/${var.project_name}_codebuild_${var.component_name}_${var.tf_step}"
  retention_in_days = 30
  lifecycle {
    create_before_destroy = true
  }
}