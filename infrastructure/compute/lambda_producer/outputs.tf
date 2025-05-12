output "ecr_repository_url" {
  description = "URL do repositório ECR onde a imagem do Lambda Producer é armazenada"
  value       = module.ecr.repository_url
}

output "image_uri" {
  description = "URI da imagem Docker utilizada pela Lambda Producer"
  value       = module.cicd.image_uri
}

output "function_name" {
  description = "Nome da função Lambda Producer"
  value       = module.lambda.function_name
}

output "function_arn" {
  description = "ARN da função Lambda Producer"
  value       = module.lambda.function_arn
}

output "api_invoke_url" {
  description = "URL de invocação pública do endpoint da API Gateway integrado à Lambda Producer"
  value       = module.lambda.invoke_url
}