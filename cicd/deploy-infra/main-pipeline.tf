resource "aws_codepipeline" "demo_infra_prod_pipeline" {
  depends_on = [aws_iam_role.demo_codepipeline_service_role]

  artifact_store {
    location = local.s3_bucket_artifact_id
    type     = "S3"
  }

  name     = local.pipeline_name
  role_arn = aws_iam_role.demo_codepipeline_service_role.arn

  pipeline_type = "V2"

  trigger {
    provider_type = "CodeStarSourceConnection"

    git_configuration {
      source_action_name = "Source"

      push {
        branches {
          includes = [local.branch_name]
        }

        file_paths {
          includes = [
            "infra/**"
          ]
        }
      }
    }
  }


  stage {
    name = "Source"
    action {
      category = "Source"

      configuration = {
        BranchName           = local.branch_name
        ConnectionArn        = local.codestar_connection_arn
        DetectChanges        = "true"
        FullRepositoryId     = local.repository_name
        OutputArtifactFormat = "CODE_ZIP"
      }

      name             = "Source"
      namespace        = "SourceVariables"
      output_artifacts = ["SourceArtifact"]
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      region           = local.aws_region
      run_order        = "1"
      version          = "1"
    }
  }


  # VPC Stage
  stage {
    name = "VPC_demo"
    action {
      category         = "Build"
      input_artifacts  = ["SourceArtifact"]
      name             = "terraform-plan"
      owner            = "AWS"
      provider         = "CodeBuild"
      region           = local.aws_region
      version          = "1"
      run_order        = "1"
      output_artifacts = ["${local.demo_vpc_component_name}_plan"]

      configuration = {
        ProjectName = module.codebuild_demo_vpc.codebuild_tf_plan_project_name
      }
    }


    action {
      name      = "Manual-Approval"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = "1"

      configuration = {
        CustomData = "Please review and approve the deployment to proceed"
      }
    }
    
    action {
      category        = "Build"
      input_artifacts = ["SourceArtifact", "${local.demo_vpc_component_name}_plan"]
      name            = "terraform-apply"
      owner           = "AWS"
      provider        = "CodeBuild"
      region          = local.aws_region
      version         = "1"
      run_order       = "3"

      configuration = {
        PrimarySource = "SourceArtifact"
        ProjectName   = module.codebuild_demo_vpc.codebuild_tf_apply_project_name
      }
    }
  }

}