# # Parent resource => /v1/sales-reconciliation/presigned-url
# resource "aws_api_gateway_resource" "get_presigned_url" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   parent_id   = aws_api_gateway_resource.test_endpoint.id
#   path_part   = "api-one"
# }

# module "get_presigned_url_cors" {
#   source          = ".//terraform-aws-api-gateway-enable-cors"
#   api_id          = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   api_resource_id = aws_api_gateway_resource.get_presigned_url.id
# }

# resource "aws_api_gateway_method" "get_presigned_url_method" {
#   rest_api_id          = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id          = aws_api_gateway_resource.get_presigned_url.id
#   request_validator_id = aws_api_gateway_request_validator.get_method_request_validator.id
#   http_method          = "GET"
#   api_key_required     = true
#   authorization        = "NONE"
#   request_parameters = {
#     "method.request.querystring.name" = true
#   }
# }

# #Integration
# resource "aws_api_gateway_integration" "get_presigned_url_integration" {
#   rest_api_id             = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id             = aws_api_gateway_resource.get_presigned_url.id
#   http_method             = aws_api_gateway_method.get_presigned_url_method.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri         = aws_lambda_function.ses_bp_portal_bff_get_presigned_url.invoke_arn
#   depends_on = [
#     aws_api_gateway_method.get_presigned_url_method,
#     aws_lambda_function.ses_bp_portal_bff_get_presigned_url
#   ]
#   request_templates = {
#     "application/json" = "${file("${local.module}/templates/get_presigned_url.template")}"
#   }
#   request_parameters = {
#     "integration.request.querystring.name" = "method.request.querystring.name"
#   }

#   passthrough_behavior = "WHEN_NO_TEMPLATES"
#   timeout_milliseconds = "15000"
# }

# #..................................................................................
# #Configuring response code 200
# #..................................................................................
# #Response
# resource "aws_api_gateway_method_response" "get_presigned_url_200_method_response" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id = aws_api_gateway_resource.get_presigned_url.id
#   http_method = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code = "200"
#   response_models = {
#     "application/json" = "Empty"
#   }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = true
#     "method.response.header.X-Content-Type-Options"      = true
#     "method.response.header.X-Frame-Options"             = true
#     "method.response.header.Strict-Transport-Security"   = true
#     "method.response.header.Content-Security-Policy"     = true
#     "method.response.header.Set-Cookie"                  = true
#   }
# }

# #Integration response
# resource "aws_api_gateway_integration_response" "get_presigned_url_200_integration_response" {
#   rest_api_id       = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id       = aws_api_gateway_resource.get_presigned_url.id
#   http_method       = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code       = aws_api_gateway_method_response.get_presigned_url_200_method_response.status_code
#   selection_pattern = "-"
#   response_templates = {
#     "application/json" = ""
#   }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#     "method.response.header.X-Content-Type-Options"      = "'nosniff'"
#     "method.response.header.X-Frame-Options"             = "'deny'"
#     "method.response.header.Strict-Transport-Security"   = "'max-age=31536000;includeSubdomains'"
#     "method.response.header.Content-Security-Policy"     = "'default-src'none''"
#     "method.response.header.Set-Cookie"                  = "integration.response.body.Cookie"
#   }
#   depends_on = [
#     aws_api_gateway_method_response.get_presigned_url_200_method_response,
#     aws_api_gateway_integration.get_presigned_url_integration
#   ]
# }

# #..................................................................................
# #Configuring response code 400
# #..................................................................................
# #Response
# resource "aws_api_gateway_method_response" "get_presigned_url_400_method_response" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id = aws_api_gateway_resource.get_presigned_url.id
#   http_method = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code = "400"
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = true
#     "method.response.header.X-Content-Type-Options"      = true
#     "method.response.header.X-Frame-Options"             = true
#     "method.response.header.Strict-Transport-Security"   = true
#     "method.response.header.Content-Security-Policy"     = true
#     "method.response.header.Set-Cookie"                  = true
#   }
#   response_models = {
#     "application/json" = "Empty"
#   }
# }

# #Integration response
# resource "aws_api_gateway_integration_response" "get_presigned_url_400_integration_response" {
#   rest_api_id       = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id       = aws_api_gateway_resource.get_presigned_url.id
#   http_method       = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code       = aws_api_gateway_method_response.get_presigned_url_400_method_response.status_code
#   selection_pattern = ".*400.*"
#   response_templates = {
#     "application/json" = "$input.path('$.errorMessage')"
#   }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#     "method.response.header.X-Content-Type-Options"      = "'nosniff'"
#     "method.response.header.X-Frame-Options"             = "'deny'"
#     "method.response.header.Strict-Transport-Security"   = "'max-age=31536000;includeSubdomains'"
#     "method.response.header.Content-Security-Policy"     = "'default-src'none''"
#     "method.response.header.Set-Cookie"                  = "integration.response.body.Cookie"
#   }
#   depends_on = [
#     aws_api_gateway_method_response.get_presigned_url_400_method_response,
#     aws_api_gateway_integration.get_presigned_url_integration
#   ]
# }

# #..................................................................................
# #Configuring response code 401
# #..................................................................................
# #Response
# resource "aws_api_gateway_method_response" "get_presigned_url_401_method_response" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id = aws_api_gateway_resource.get_presigned_url.id
#   http_method = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code = "401"
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = true
#     "method.response.header.X-Content-Type-Options"      = true
#     "method.response.header.X-Frame-Options"             = true
#     "method.response.header.Strict-Transport-Security"   = true
#     "method.response.header.Content-Security-Policy"     = true
#     "method.response.header.Set-Cookie"                  = true
#   }
#   response_models = {
#     "application/json" = "Empty"
#   }
# }

# #Integration response
# resource "aws_api_gateway_integration_response" "get_presigned_url_401_integration_response" {
#   rest_api_id       = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id       = aws_api_gateway_resource.get_presigned_url.id
#   http_method       = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code       = aws_api_gateway_method_response.get_presigned_url_401_method_response.status_code
#   selection_pattern = ".*401.*"
#   response_templates = {
#     "application/json" = "$input.path('$.errorMessage')"
#   }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#     "method.response.header.X-Content-Type-Options"      = "'nosniff'"
#     "method.response.header.X-Frame-Options"             = "'deny'"
#     "method.response.header.Strict-Transport-Security"   = "'max-age=31536000;includeSubdomains'"
#     "method.response.header.Content-Security-Policy"     = "'default-src'none''"
#     "method.response.header.Set-Cookie"                  = "integration.response.body.Cookie"
#   }
#   depends_on = [
#     aws_api_gateway_method_response.get_presigned_url_401_method_response,
#     aws_api_gateway_integration.get_presigned_url_integration
#   ]
# }

# #..................................................................................
# #Configuring response code 403
# #..................................................................................
# #Response
# resource "aws_api_gateway_method_response" "get_presigned_url_403_method_response" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id = aws_api_gateway_resource.get_presigned_url.id
#   http_method = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code = "403"
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = true
#     "method.response.header.X-Content-Type-Options"      = true
#     "method.response.header.X-Frame-Options"             = true
#     "method.response.header.Strict-Transport-Security"   = true
#     "method.response.header.Content-Security-Policy"     = true
#     "method.response.header.Set-Cookie"                  = true
#   }
#   response_models = {
#     "application/json" = "Empty"
#   }
# }

# #Integration response
# resource "aws_api_gateway_integration_response" "get_presigned_url_403_integration_response" {
#   rest_api_id       = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id       = aws_api_gateway_resource.get_presigned_url.id
#   http_method       = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code       = aws_api_gateway_method_response.get_presigned_url_403_method_response.status_code
#   selection_pattern = ".*403.*"
#   response_templates = {
#     "application/json" = "$input.path('$.errorMessage')"
#   }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#     "method.response.header.X-Content-Type-Options"      = "'nosniff'"
#     "method.response.header.X-Frame-Options"             = "'deny'"
#     "method.response.header.Strict-Transport-Security"   = "'max-age=31536000;includeSubdomains'"
#     "method.response.header.Content-Security-Policy"     = "'default-src'none''"
#     "method.response.header.Set-Cookie"                  = "integration.response.body.Cookie"
#   }
#   depends_on = [
#     aws_api_gateway_method_response.get_presigned_url_403_method_response,
#     aws_api_gateway_integration.get_presigned_url_integration
#   ]
# }

# #..................................................................................
# #Configuring response code 404
# #..................................................................................
# #Response
# resource "aws_api_gateway_method_response" "get_presigned_url_404_method_response" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id = aws_api_gateway_resource.get_presigned_url.id
#   http_method = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code = "404"
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = true
#     "method.response.header.X-Content-Type-Options"      = true
#     "method.response.header.X-Frame-Options"             = true
#     "method.response.header.Strict-Transport-Security"   = true
#     "method.response.header.Content-Security-Policy"     = true
#     "method.response.header.Set-Cookie"                  = true
#   }
#   response_models = {
#     "application/json" = "Empty"
#   }
# }

# #Integration response
# resource "aws_api_gateway_integration_response" "get_presigned_url_404_integration_response" {
#   rest_api_id       = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id       = aws_api_gateway_resource.get_presigned_url.id
#   http_method       = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code       = aws_api_gateway_method_response.get_presigned_url_404_method_response.status_code
#   selection_pattern = ".*404.*"
#   response_templates = {
#     "application/json" = <<TEMPLATE
#       #set ($errorMessageObj = $util.parseJson($input.path('$.errorMessage')))
#       {
#         "status" : "$errorMessageObj.status",
#         "message" : $errorMessageObj.message
#       }
#     TEMPLATE
#   }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#     "method.response.header.X-Content-Type-Options"      = "'nosniff'"
#     "method.response.header.X-Frame-Options"             = "'deny'"
#     "method.response.header.Strict-Transport-Security"   = "'max-age=31536000;includeSubdomains'"
#     "method.response.header.Content-Security-Policy"     = "'default-src'none''"
#     "method.response.header.Set-Cookie"                  = "integration.response.body.Cookie"
#   }
#   depends_on = [
#     aws_api_gateway_method_response.get_presigned_url_404_method_response,
#     aws_api_gateway_integration.get_presigned_url_integration
#   ]
# }

# #..................................................................................
# #Configuring response code 500
# #..................................................................................
# #Response
# resource "aws_api_gateway_method_response" "get_presigned_url_500_method_response" {
#   rest_api_id = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id = aws_api_gateway_resource.get_presigned_url.id
#   http_method = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code = "500"
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = true
#     "method.response.header.X-Content-Type-Options"      = true
#     "method.response.header.X-Frame-Options"             = true
#     "method.response.header.Strict-Transport-Security"   = true
#     "method.response.header.Content-Security-Policy"     = true
#     "method.response.header.Set-Cookie"                  = true
#   }
#   response_models = {
#     "application/json" = "Empty"
#   }
# }

# #Integration response
# resource "aws_api_gateway_integration_response" "get_presigned_url_500_integration_response" {
#   rest_api_id       = aws_api_gateway_rest_api.ses_local_stack_test_bff.id
#   resource_id       = aws_api_gateway_resource.get_presigned_url.id
#   http_method       = aws_api_gateway_method.get_presigned_url_method.http_method
#   status_code       = aws_api_gateway_method_response.get_presigned_url_500_method_response.status_code
#   selection_pattern = ".*500*."
#   response_templates = {
#     "application/json" = <<TEMPLATE
#       #set ($errorMessageObj = $util.parseJson($input.path('$.errorMessage')))
#       {
#         "status" : "$errorMessageObj.status",
#         "message" : "Internal Server Error"
#       }
#     TEMPLATE
#   }
#   response_parameters = {
#     "method.response.header.Access-Control-Allow-Origin" = "'*'"
#     "method.response.header.X-Content-Type-Options"      = "'nosniff'"
#     "method.response.header.X-Frame-Options"             = "'deny'"
#     "method.response.header.Strict-Transport-Security"   = "'max-age=31536000;includeSubdomains'"
#     "method.response.header.Content-Security-Policy"     = "'default-src'none''"
#     "method.response.header.Set-Cookie"                  = "integration.response.body.Cookie"
#   }
#   depends_on = [
#     aws_api_gateway_method_response.get_presigned_url_500_method_response,
#     aws_api_gateway_integration.get_presigned_url_integration
#   ]
# }
