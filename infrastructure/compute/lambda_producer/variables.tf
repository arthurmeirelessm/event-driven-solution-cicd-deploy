variable "region"             { type = string }
variable "repo_owner"         { type = string }
variable "repo_name"          { type = string }
variable "branch"             { type = string }

variable "codebuild_role_arn" { type = string }
variable "pipeline_role_arn"  { type = string }
variable "lambda_exec_role"   { type = string }

variable "shared_api_endpoint"{ type = string }
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
variable "memory_size"        { type = number  , default = 128 }
variable "timeout"            { type = number  , default = 30 }
variable "environment_variables" { type = map(string), default = {} }

# Integração API Gateway
variable "integrate_with_api_gateway" { type = bool, default = false }
variable "http_method"                { type = string, default = "" }
variable "rest_api_id"                { type = string, default = "" }
variable "resource_id"                { type = string, default = "" }

variable "tags"             { type = map(string), default = {} }
