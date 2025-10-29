output "codebuild_tf_plan_project_name" {
  description = "The name of the CodeBuild project for the plan stage"
  value       = aws_codebuild_project.this_plan.name
}

output "codebuild_tf_apply_project_name" {
  description = "The name of the CodeBuild project for the apply stage"
  value       = aws_codebuild_project.this_apply.name
}

output "codebuild_tf_destroy_project_name" {
  description = "The name of the CodeBuild project for the destroy stage"
  value       = var.tf_destroy_build_spec != null ? aws_codebuild_project.this_destroy[0].name : null
}