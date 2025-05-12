##### ECR #####
module "ecr" {
  source         = "../../modules/ecr"
  repo_name      = var.ecr_repo_name
  region         = var.region
  tags           = var.tags
  push_image     = var.push_image
  docker_context = var.docker_context
}

##### CICD (CodeBuild + CodePipeline via CodeStar Connection) #####
module "cicd" {
  source                  = "../../modules/cicd"
  project_name            = var.project_name
  pipeline_name           = var.pipeline_name
  repo_owner              = var.repo_owner
  repo_name               = var.repo_name
  branch                  = var.branch
  source_filters          = var.source_filters
  codestar_connection_arn = var.codestar_connection_arn
  ecr_repo_uri            = module.ecr.repository_url
  codebuild_role_arn      = var.codebuild_role_arn
  pipeline_role_arn       = var.pipeline_role_arn
  tags                    = var.tags
}

##### LAMBDA + SQS TRIGGER #####
module "lambda" {
  source                    = "../../modules/serverless"
  function_name             = var.function_name
  ecr_image_uri             = module.cicd.image_uri
  role_arn                  = var.lambda_exec_role

  memory_size               = var.memory_size
  timeout                   = var.timeout
  environment_variables     = var.environment_variables

  # Configuração do trigger SQS
  event_source_mappings = [
    {
      event_source_arn = var.sqs_event_source_arn
      batch_size       = var.batch_size
    }
  ]

  tags                      = var.tags
}
