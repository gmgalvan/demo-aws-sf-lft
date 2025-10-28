output "codebuild_tf_plan_project_name" {
  description = "The name of the CodeBuild project for the plan stage"
  value       = aws_codebuild_project.this_plan.name
}

output "codebuild_tf_apply_project_name" {
  description = "The name of the CodeBuild project for the apply stage"
  value       = aws_codebuild_project.this_apply.name
}
