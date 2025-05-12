variable "api_name" {
  description = "Nome da API Gateway REST"
  type        = string
}

variable "api_description" {
  description = "Descrição da API Gateway"
  type        = string
  default     = ""
}

variable "endpoint_type" {
  description = "Tipo de endpoint da API (EDGE, REGIONAL, PRIVATE)"
  type        = string
  default     = "REGIONAL"
}

variable "queue_name" {
  description = "Nome da fila SQS"
  type        = string
}

variable "queue_visibility_timeout_seconds" {
  description = "Timeout de visibilidade da SQS (segundos)"
  type        = number
  default     = 30
}

variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "tags" {
  description = "Tags aplicadas a todos os recursos compartilhados"
  type        = map(string)
}
