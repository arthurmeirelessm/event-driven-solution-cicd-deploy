output "ecr_repository_url" {
  description = "URL do repositório ECR onde a imagem do Lambda SQS Consumer é armazenada"
  value       = module.ecr.repository_url
}

output "image_uri" {
  description = "URI da imagem Docker utilizada pela Lambda SQS Consumer"
  value       = module.cicd.image_uri
}

output "function_name" {
  description = "Nome da função Lambda SQS Consumer"
  value       = module.lambda.function_name
}

output "function_arn" {
  description = "ARN da função Lambda SQS Consumer"
  value       = module.lambda.function_arn
}