module "shared" {
  source      = "./infrastructure/modules/shared"
  api_name    = var.api_name
  queue_name  = var.queue_name
  bucket_name = var.bucket_name
  tags        = var.tags
}

module "compute" {
  source        = "./infrastructure/modules/compute"
  function_name = var.api_proxy_name
  image_uri     = module.ci_cd_api_proxy.image_uri
  role_arn      = var.lambda_exec_role
  tags          = var.tags
}

module "cicd" {
  source                  = "./infrastructure/modules/cicd"
  lambda_name             = module.lambda_function.lambda_function_name
  build_project_name      = "cicdBuildTest"
  pipeline_name           = "cicdPipelineTest"
  artifact_bucket         = "cicd-arctifact-test-arthur"
  repository_name         = "aws-lambda-cicd-deploy"
  branch_name             = "main"
  codestar_connection_arn = "arn:aws:codeconnections:us-east-1:552516487395:connection/8a96bc9c-b145-48e3-a7ed-cff71f551f36"
  github_owner            = "arthurmeirelessm"
  github_oauth_token      =  var.github_oauth_token
  layer_name              = "cicdLayerLambda"
  aws_region              = "us-east-1"
  layer_bucket            = "cicd-layer-repository"
  aws_account_id          = "552516487395"
}

