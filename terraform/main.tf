provider "aws" {

  access_key  = "test"
  secret_key  = "test"
  region     = "us-east-1"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
     apigateway     = "http://localhost:4566"
    apigatewayv2   = "http://localhost:4566"
    acm            = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    es             = "http://localhost:4566"
    elasticache    = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    kms            = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    rds            = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    route53        = "http://localhost:4566"
    s3             = "http://s3.localhost.localstack.cloud:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
    cloudwatchlogs = "http://localhost:4566"
  }

}



# # Create an S3 bucket
# resource "aws_s3_bucket" "my_bucket" {
#   bucket = "localstack-test-bucket-v1"  # Replace with your desired bucket name

#   tags = {
#     Name        = "localstack-test-bucket-v1"
#     Environment = "dev"
#   }
# }

# # Configure the bucket to be private
# resource "aws_s3_bucket_public_access_block" "my_bucket_access" {
#   bucket = aws_s3_bucket.my_bucket.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # Enable server-side encryption for the bucket
# resource "aws_s3_bucket_server_side_encryption_configuration" "my_bucket_encryption" {
#   bucket = aws_s3_bucket.my_bucket.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }



# resource "aws_api_gateway_rest_api" "example" {
#   name        = "example-api"
#   description = "Example API Gateway"
# }

# resource "aws_api_gateway_resource" "example" {
#   rest_api_id = aws_api_gateway_rest_api.example.id
#   parent_id   = aws_api_gateway_rest_api.example.root_resource_id
#   path_part   = "example"
# }

# resource "aws_api_gateway_method" "example" {
#   rest_api_id   = aws_api_gateway_rest_api.example.id
#   resource_id   = aws_api_gateway_resource.example.id
#   http_method   = "GET"
#   authorization = "NONE"
# }

# resource "aws_api_gateway_integration" "example" {
#   rest_api_id = aws_api_gateway_rest_api.example.id
#   resource_id = aws_api_gateway_resource.example.id
#   http_method = aws_api_gateway_method.example.http_method
#   type        = "MOCK"
# }

# resource "aws_api_gateway_deployment" "example" {
#   depends_on = [aws_api_gateway_integration.example]

#   rest_api_id = aws_api_gateway_rest_api.example.id
#   stage_name  = "test"
# }
