# # data "aws_vpcs" "integration" {
# #   tags = {
# #     Name = "StudentPlacement-${var.env}"
# #   }
# # }

# # locals {
# #   aws_vpcs_string = join(",", data.aws_vpcs.integration.ids)
# #   aws_vpcs_list   = split(",", local.aws_vpcs_string)
# # }

# # data "aws_vpc" "integration" {
# #   id = local.aws_vpcs_list[0]
# # }

# # data "aws_subnets" "private" {
# #   filter {
# #     name   = "vpc-id"
# #     values = [data.aws_vpc.integration.id]
# #   }
# #   tags = {
# #     Tier = "private"
# #   }
# # }

# # locals {
# #   subnet_ids_string = join(",", data.aws_subnets.private.ids)
# #   subnet_ids_list   = split(",", local.subnet_ids_string)
# # }

# # data "aws_subnet" "private-a" {
# #   id = local.subnet_ids_list[2]
# # }

# # data "aws_subnet" "private-b" {
# #   id = local.subnet_ids_list[0]
# # }

# # data "aws_subnet" "private-c" {
# #   id = local.subnet_ids_list[1]
# # }

# # data "aws_security_groups" "integration-security-group-bff" {
# #   tags = {
# #     Name = "${var.env}-integration-security-group-bff"
# #   }
# # }

# # locals {
# #   aws_security_groups_string_bff = join(",", data.aws_security_groups.integration-security-group-bff.ids)
# #   aws_security_groups_list_bff   = split(",", local.aws_security_groups_string_bff)
# # }

# # data "aws_security_group" "integration-security-group-bff" {
# #   id = local.aws_security_groups_list_bff[0]
# # }

# # data "aws_kms_key" "integration-key" {
# #   key_id = "alias/integration-key"
# # }

# # data "aws_wafv2_web_acl" "student_essentials_bff_wafacl" {
# #   name = "Wafrule-APIGateway-student-essestials-Singapore-${var.env}"
# #   scope = "REGIONAL"
# # }

# # data "aws_cognito_user_pools" "staff_cognito_user_pool" {
# #   name = "${var.env}-idp-staff-user-pool"
# # }


# data "aws_vpcs" "integration" {
#   count = var.is_pipeline ? 1 : 0
#   tags = {
#     Name = "StudentPlacement-${var.env}"
#   }
# }

# locals {
#   aws_vpcs_string = var.is_pipeline ? join(",", data.aws_vpcs.integration[0].ids) : ""
#   aws_vpcs_list   = var.is_pipeline ? split(",", local.aws_vpcs_string) : []
# }

# data "aws_vpc" "integration" {
#   count = var.is_pipeline ? 1 : 0
#   id    = var.is_pipeline ? local.aws_vpcs_list[0] : null
# }

# data "aws_subnets" "private" {
#   count = var.is_pipeline ? 1 : 0
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.integration[0].id]
#   }
#   tags = {
#     Tier = "private"
#   }
# }

# locals {
#   subnet_ids_string = var.is_pipeline ? join(",", data.aws_subnets.private[0].ids) : ""
#   subnet_ids_list   = var.is_pipeline ? split(",", local.subnet_ids_string) : []
# }

# data "aws_subnet" "private-a" {
#   count = var.is_pipeline && length(local.subnet_ids_list) > 0 ? 1 : 0
#   id    = local.subnet_ids_list[0]
# }

# data "aws_subnet" "private-b" {
#   count = var.is_pipeline && length(local.subnet_ids_list) > 1 ? 1 : 0
#   id    = local.subnet_ids_list[1]
# }

# data "aws_subnet" "private-c" {
#   count = var.is_pipeline && length(local.subnet_ids_list) > 2 ? 1 : 0
#   id    = local.subnet_ids_list[2]
# }

# # Continue this pattern for other data blocks...
# data "aws_security_groups" "integration-security-group-bff" {
#   count = var.is_pipeline ? 1 : 0
#   tags = {
#     Name = "${var.env}-integration-security-group-bff"
#   }
# }

# locals {
#   aws_security_groups_string_bff = var.is_pipeline ? join(",", data.aws_security_groups.integration-security-group-bff[0].ids) : ""
#   aws_security_groups_list_bff   = var.is_pipeline ? split(",", local.aws_security_groups_string_bff) : []
# }

# data "aws_security_group" "integration-security-group-bff" {
#   count = var.is_pipeline ? 1 : 0
#   id = local.aws_security_groups_list_bff[0]
# }

# data "aws_kms_key" "integration-key" {
#   count = var.is_pipeline ? 1 : 0
#   key_id = "alias/integration-key"
# }

# data "aws_wafv2_web_acl" "student_essentials_bff_wafacl" {
#   count = var.is_pipeline ? 1 : 0
#   name = "Wafrule-APIGateway-student-essestials-Singapore-${var.env}"
#   scope = "REGIONAL"
# }

# data "aws_cognito_user_pools" "staff_cognito_user_pool" {
#   count = var.is_pipeline ? 1 : 0
#   name = "${var.env}-idp-staff-user-pool"
# }