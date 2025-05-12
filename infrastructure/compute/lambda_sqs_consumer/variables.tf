# Variáveis comuns
variable "region"             { type = string }
variable "repo_owner"         { type = string }
variable "repo_name"          { type = string }
variable "branch"             { type = string }

variable "codebuild_role_arn" { type = string }
variable "pipeline_role_arn"  { type = string }
variable "lambda_exec_role"   { type = string }

# Integração com recursos compartilhados
variable "shared_queue_url"   { type = string }

# Controle de trigger via filtro de pasta
variable "lambda_folder_path" { type = string }

# ECR
variable "ecr_repo_name"      { type = string }
variable "docker_context"     { type = string }
variable "push_image"         { type = bool }

# CodeBuild / CodePipeline
variable "project_name"       { type = string }
variable "pipeline_name"      { type = string }
variable "source_filters"     { type = list(string) }

# Lambda settings
variable "function_name"      { type = string }
variable "memory_size"        { type = number, default = 128 }
variable "timeout"            { type = number, default = 30 }
variable "environment_variables" { type = map(string), default = {} }

# Integração SQS (trigger)
variable "sqs_event_source_arn"   { type = string, default = "" }
variable "batch_size"             { type = number, default = 10 }

variable "tags"             { type = map(string), default = {} }
