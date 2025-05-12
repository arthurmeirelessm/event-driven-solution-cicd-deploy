# ESTRUTURA GLOBAL - SERVIÇOS COMPARTILHADOS

module "shared" {
  source      = "./infrastructure/modules/shared"

  api_name    = var.api_name
  queue_name  = var.queue_name
  bucket_name = var.bucket_name
  tags        = var.tags
}

# LAMBDA PRODUCER - API Gateway Proxy + CodePipeline

module "lambda_producer" {
  source               = "./infrastructure/compute/lambda_producer"

  # Comuns
  region               = var.region
  repo_owner           = var.repo_owner
  repo_name            = var.repo_name
  branch               = var.branch
  codebuild_role_arn   = var.codebuild_role_arn
  pipeline_role_arn    = var.pipeline_role_arn
  lambda_exec_role     = var.lambda_exec_role
  shared_api_endpoint  = module.shared.api_gateway_url
  lambda_folder_path   = "src/lambdas/lambda_producer/"

  # ECR
  ecr_repo_name        = "lambda-producer"
  docker_context       = "src/lambdas/lambda_producer"
  push_image           = true

  # CI/CD
  project_name         = "producer-build"
  pipeline_name        = "producer-pipeline"
  source_filters       = [
    "src/lambdas/lambda_producer/**",
    "infrastructure/compute/lambda_producer/**",
  ]

  # Lambda
  function_name        = "lambda-producer-fn"
  memory_size          = 256
  timeout              = 30
  environment_variables = {
    API_URL = module.shared.api_gateway_url
  }

  integrate_with_api_gateway = true
  http_method                = "POST"
  rest_api_id                = module.shared.api_gateway_id
  resource_id                = module.shared.api_gateway_root_resource_id

  tags = var.tags
}


# LAMBDA CONSUMER - SQS Consumer + CodePipeline

module "lambda_sqs_consumer" {
  source = "./infrastructure/compute/lambda_sqs_consumer"

  # Comuns
  region               = var.region
  repo_owner           = var.repo_owner
  repo_name            = var.repo_name
  branch               = var.branch
  codebuild_role_arn   = var.codebuild_role_arn
  pipeline_role_arn    = var.pipeline_role_arn
  lambda_exec_role     = var.lambda_exec_role

  # Shared
  shared_queue_url     = module.shared.queue_url

  # Filtro de path para trigger de push
  lambda_folder_path   = "src/lambdas/lambda_sqs_consumer/"

  # ECR
  ecr_repo_name        = "lambda-sqs-consumer"
  docker_context       = "src/lambdas/lambda_sqs_consumer"
  push_image           = true

  # CI/CD
  project_name         = "sqs-consumer-build"
  pipeline_name        = "sqs-consumer-pipeline"
  source_filters       = [
    "src/lambdas/lambda_sqs_consumer/**",
    "infrastructure/compute/lambda_sqs_consumer/**",
  ]

  # Lambda
  function_name        = "lambda-sqs-consumer-fn"
  memory_size          = 256
  timeout              = 30
  environment_variables = {
    QUEUE_URL = module.shared.queue_url
  }

  # Integração SQS (event source mapping)
  sqs_event_source_arn = module.shared.queue_arn
  batch_size           = 10

  tags = var.tags
}
