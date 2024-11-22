# resource "aws_api_gateway_rest_api" "ses_local_stack_test_bff" {
#   name        = "${var.env}-ses-localstack-test-bff"
#   description = "Students Essentials - Local Stack Test BFF"

#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }

# }

# # Parent resource => /v1
# resource "aws_api_gateway_resource" "v1" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   parent_id   = aws_api_gateway_rest_api.ses_local_stack_test_bff.root_resource_id
#   path_part   = "v1"
# }

# # Parent resource => /v1/sales-reconciliation
# resource "aws_api_gateway_resource" "test_endpoint" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   parent_id   = aws_api_gateway_resource.v1.id
#   path_part   = "test-endpoint"
# }

# resource "aws_api_gateway_deployment" "ses_local_stack_test_bff_deployment" {
#   rest_api_id       = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   stage_description = var.deployment
#   description       = var.deployment
#   depends_on = [
#     aws_api_gateway_integration.get_presigned_url_integration
#   ]
#   variables = {
#     "lambdaAlias" = var.env
#   }
#   triggers = {
#     redeployment = sha1(join(",", tolist([timestamp()])))
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_cloudwatch_log_group" "api_log" {
#   name = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.ses_local_stack_test_bff.id}/${var.env}"
#   retention_in_days = 5
#   # tags   = merge(local.# tags, { Name = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.ses_local_stack_test_bff.id}/${var.env}"})
# }

# resource "aws_api_gateway_stage" "ses_local_stack_test_bff_stage" {
#   stage_name           = var.env
#   rest_api_id          = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   deployment_id        = aws_api_gateway_deployment.ses_local_stack_test_bff_deployment.id
#   xray_tracing_enabled = true
#   variables = {
#     "lambdaAlias" = "${var.env}"
#   }

#   access_log_settings {
#     destination_arn = "arn:aws:logs:us-east-1:000000000000:log-group:API-Gateway-Execution-Logs_fqy9q43nzd/dev:*"
#     format = jsonencode({
#       "requestId" : "$context.requestId",
#       "requestTime" : "$context.requestTime",
#       "ip" : "$context.identity.sourceIp",
#       "userAgent" : "$context.identity.userAgent",
#       "caller" : "$context.identity.caller",
#       "user" : "$context.identity.user",
#       "httpMethod" : "$context.httpMethod",
#       "protocol" : "$context.protocol",
#       "apiPath" : "$context.path",
#       "resourcePath" : "$context.resourcePath",
#       "status" : "$context.status",
#       "authenticateResultStatus" : "$context.authenticate.status",
#       "authorizeResultStatus" : "$context.authorize.status",
#       "apiResponseLatency" : "$context.responseLatency",
#       "responseLength" : "$context.responseLength",
#       "apiId" : "$context.apiId",
#       "AWSaccountId" : "$context.accountId"
#     })
#   }

#   }
#   # tags = merge(local.# tags, { Name = "ses_local_stack_test_bff_stage" })


# resource "aws_api_gateway_method_settings" "ses_local_stack_test_bff_method_settings" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   stage_name  = aws_api_gateway_stage.ses_local_stack_test_bff_stage.stage_name
#   method_path = "*/*"
#   settings {
#     metrics_enabled        = "true"
#     logging_level          = "INFO"
#     data_trace_enabled     = "true"
#     throttling_burst_limit = 5000
#     throttling_rate_limit  = 10000
#   }
# }

# resource "aws_api_gateway_gateway_response" "ses-bp-portal-bff-v1-4xx-gateway_response" {
#   rest_api_id   = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   response_type = "DEFAULT_4XX"

#   response_parameters = {
#     "gatewayresponse.header.Strict-Transport-Security" = "'max-age=63072000;includeSubDomains;preload'"
#     "gatewayresponse.header.Content-Security-Policy"   = "'default-src'none''"
#   }
# }

# resource "aws_api_gateway_gateway_response" "ses-bp-portal-bff-v1-5xx-gateway_response" {
#   rest_api_id   = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   response_type = "DEFAULT_5XX"

#   response_parameters = {
#     "gatewayresponse.header.Strict-Transport-Security" = "'max-age=63072000;includeSubDomains;preload'"
#     "gatewayresponse.header.Content-Security-Policy"   = "'default-src'none''"
#   }
# }

# # Common Request validator {GET}.
# resource "aws_api_gateway_request_validator" "get_method_request_validator" {
#   name                        = "get-method-request-validator"
#   rest_api_id                 = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   validate_request_body       = false
#   validate_request_parameters = true
# }

# # Common Request validator {POST}.
# resource "aws_api_gateway_request_validator" "post_method_request_validator" {
#   name                        = "post-method-request-validator"
#   rest_api_id                 = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   validate_request_body       = true
#   validate_request_parameters = true
# }

# # X-API key 
# resource "aws_api_gateway_api_key" "ses_local_stack_test_bff_api_key" {
#   name = "${var.env}-ses-business-process-portal-bff-api-key"
#   # tags = merge(
#     # local.# tags,
#   #   { 
#   #     Classification = "confidential",
#   #     Name = "${var.env}-ses-business-process-portal-bff-api-key"
#   #   }
#   # )
# }

# # usage plan
# resource "aws_api_gateway_usage_plan" "ses_local_stack_test_bff_usage_plan" {
#   name = "${var.env}-ses-business-process-portal-bff-usage-plan"
#   api_stages {
#     api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#     stage  = aws_api_gateway_stage.ses_local_stack_test_bff_stage.stage_name
#   }
#   depends_on = [ 
#     aws_api_gateway_stage.ses_local_stack_test_bff_stage
#    ]
# }

# resource "aws_api_gateway_usage_plan_key" "ses_local_stack_test_bff_usage_plan_key" {
#   key_id        = aws_api_gateway_api_key.ses_local_stack_test_bff_api_key.id
#   key_type      = "API_KEY"
#   usage_plan_id = aws_api_gateway_usage_plan.ses_local_stack_test_bff_usage_plan.id
# }

# # enabling WAF
# resource "aws_wafv2_web_acl_association" "ses_local_stack_test_bff_wafv2" {

#   count = var.is_pipeline ? 1 : 0

#   resource_arn = aws_api_gateway_stage.ses_local_stack_test_bff_stage.arn
#   web_acl_arn  = data.aws_wafv2_web_acl.student_essentials_bff_wafacl[0].arn
#   depends_on = [
#     aws_api_gateway_rest_api.ses_local_stack_test_bff,
#     aws_api_gateway_deployment.ses_local_stack_test_bff_deployment
#   ]
# }