resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = var.api_description
  endpoint_configuration {
    types = [var.endpoint_type]   # EDGE, REGIONAL ou PRIVATE
  }
  tags = var.tags
}

resource "aws_sqs_queue" "this" {
  name                       = var.queue_name
  visibility_timeout_seconds = var.queue_visibility_timeout_seconds
  tags                       = var.tags
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.bucket_acl
  tags   = var.tags
}
