###############################################################################
# Module: infrastructure/modules/cicd/main.tf
# Purpose: Cria CodeBuild + CodePipeline (via CodeStar Connection) com filtros de path
###############################################################################

# Pipeline (CodePipeline)
resource "aws_codepipeline" "this" {
  name     = var.pipeline_name
  role_arn = var.pipeline_role_arn

  artifact_store {
    type     = "S3"
    location = var.artifact_bucket_name
  }

  stage {
    name = "Source"

    action {
      name             = "GitHubSource"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.codestar_connection_arn
        FullRepositoryId = "${var.repo_owner}/${var.repo_name}"
        BranchName       = var.branch
        DetectChanges    = "false"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.this.name
      }
    }
  }

  # Adicione outros estágios (Deploy) conforme necessário

  tags = var.tags
}

# Webhook para filtros de path no GitHub
resource "aws_codepipeline_webhook" "this" {
  name            = "${var.pipeline_name}-webhook"
  target_pipeline = aws_codepipeline.this.name
  target_action   = "GitHubSource"
  authentication  = "GITHUB_HMAC"

  authentication_configuration {
    secret_token = var.webhook_secret
  }

  dynamic "filter" {
    for_each = var.source_filters
    content {
      json_path    = "$.commits[0].modified"
      match_equals = filter.value
    }
  }
}
