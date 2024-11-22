# module "package_ses_bp_portal_bff_get_presigned_url" {
#   source          = "terraform-aws-modules/lambda/aws"
#   create_function = false
#   version         = "4.18.0"
#   runtime         = "python3.11"
#   source_path = [
#     {
#       path          = "${path.module}/../src/get_presigned_url",
#       prefix_in_zip = "ses_get_presigned_url"
#       patterns = [
#         "!src/ses_get_presigned_url/__pycache__/?.*",
#       ]
#     },
#     {
#       path          = "${path.module}/../src/common",
#       prefix_in_zip = "common"
#       patterns = [
#         "!src/common/__pycache__/?.*",
#       ]
#     }
#   ]

# }

# # uploads Lambda zip file as object to S3 s3_bucket
# resource "aws_s3_object" "package_ses_bp_portal_bff_get_presigned_url_obj" {
#   bucket                 = var.s3_bucket_name
#   key                    = "source-code/business-process-portal-bff/${timestamp()}-${module.package_ses_bp_portal_bff_get_presigned_url.local_filename}"
#   source                 = module.package_ses_bp_portal_bff_get_presigned_url.local_filename
#   # depends_on             = [module.package_ses_bp_portal_bff_get_presigned_url]
#   server_side_encryption = "AES256"
#   depends_on = [
#     aws_s3_bucket.my_bucket,
#     module.package_ses_bp_portal_bff_get_presigned_url
#   ]
# }



# resource "aws_lambda_function" "ses_bp_portal_bff_get_presigned_url" {
#   function_name = "${var.env}-ses-bp-portal-bff-get-presigned-url"
#   description   = "This lambda is to gererate the presigned url for the quarantine s3 bucket"
#   s3_bucket     = var.s3_bucket_name
#   architectures = ["arm64"]
#   memory_size   = "512"
#   timeout       = "300"
#   # layers        = [module.ses_lambda_layer.lambda_layer_arn]
#   s3_key        = aws_s3_object.package_ses_bp_portal_bff_get_presigned_url_obj.id
#   handler       = "ses_get_presigned_url.main.handler"
#   runtime       = "python3.11"
#   role          = aws_iam_role.iam_ses_bp_portal_bff_get_presigned_url_lambda_exe_role.arn

#   tracing_config {
#     mode = "Active"
#   }

#   dynamic "vpc_config" {
#     for_each = var.is_pipeline ? [1] : []
#     content {
#     subnet_ids         = local.subnet_ids_list
#     security_group_ids = local.aws_security_groups_list_bff
#   }
#   }

#   depends_on = [
#     aws_s3_object.package_ses_bp_portal_bff_get_presigned_url_obj,
#     aws_iam_role.iam_ses_bp_portal_bff_get_presigned_url_lambda_exe_role
#   ]

#   environment {
#     variables = {
#       STAGE               = var.env
#       REGION              = var.region

#       # QUARANTINE_ACCOUNT_ID  = aws_ssm_parameter.quarantine_account_id.name
#       # QUARANTINE_KMS_KEY_ID  = aws_ssm_parameter.quarantine_kms_key_id.name
#     }
#   }
# }

# resource "aws_lambda_permission" "get_presigned_url_lambda_api_persmission" {
#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.ses_bp_portal_bff_get_presigned_url.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.ses_local_stack_test_bff.execution_arn}/${var.env}/GET/v1/test-endpoint/api-one"
# }

# #******************************************************************************

# # Declaration for Creating IAM Role
# resource "aws_iam_role" "iam_ses_bp_portal_bff_get_presigned_url_lambda_exe_role" {
#   name               = "${var.env}-ses-bp-portal-bff-get-presigned-url-exe-role"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF

# }

# resource "aws_iam_policy" "ses_bp_portal_bff_get_presigned_url_lambda_exe_policy" {
#   name        = "${var.env}-ses-bp-portal-bff-get-presigned-url-lambda-exe-policy"
#   description = "This lambda policy is ${var.env}-ses-bp-portal-bff-get-presigned-url lambda"
#   policy      = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
# 	    "Action": [
#         "xray:PutTraceSegments",
# 				"xray:PutTelemetryRecords"
# 	    ],
#       "Effect": "Allow",
#       "Resource": "*"
#     },
#     {
# 	    "Action": [
# 				"logs:CreateLogGroup"
# 	    ],
#       "Effect": "Allow",
#       "Resource": "*"
#     },
#     {
# 	    "Action": [
# 				"logs:CreateLogStream",
# 				"logs:PutLogEvents",
# 				"logs:DescribeLogStreams"
# 	    ],
#       "Effect": "Allow",
#       "Resource": "*"
#     },
#     {
#       "Action": [
#         "ec2:DescribeNetworkInterfaces",
# 				"ec2:CreateNetworkInterface",
# 				"ec2:DeleteNetworkInterface"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     },
#     {
#       "Action": [
#         "kms:Decrypt",
#         "kms:Encrypt",
#         "kms:DescribeKey",
#         "kms:ListKeys",
#         "kms:GenerateDataKey"
#       ],
#       "Effect": "Allow",
#       "Resource": [
#         "*"
#       ]
#     },
#     {
#       "Action": [
#         "s3:GetObject",
#         "s3:GetObjectAcl",
#         "s3:ListJobs",
#         "s3:ListBucketMultipartUploads",
#         "s3:GetBucketAcl",
#         "s3:ListAllMyBuckets",
#         "s3:PutObject",
#         "s3:PutObjectAcl"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     },
#     {
#     "Action": [
#       "ssm:PutParameter",
#       "ssm:GetParameterHistory",
#       "ssm:GetParametersByPath",
#       "ssm:GetParameters",
#       "ssm:GetParameter"
#     ],
#     "Effect": "Allow",
#     "Resource": "*"
#   }
#   ]
# }
# EOF
# }

# # Declaration for Attaching Policy to IAM Role
# resource "aws_iam_role_policy_attachment" "ses_bp_portal_bff_get_presigned_url_lambda_exe_policy_attach" {
#   role       = aws_iam_role.iam_ses_bp_portal_bff_get_presigned_url_lambda_exe_role.name
#   policy_arn = aws_iam_policy.ses_bp_portal_bff_get_presigned_url_lambda_exe_policy.arn
#   depends_on = [ 
#     aws_iam_role.iam_ses_bp_portal_bff_get_presigned_url_lambda_exe_role,
#     aws_iam_policy.ses_bp_portal_bff_get_presigned_url_lambda_exe_policy
#    ]
# }
