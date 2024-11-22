resource "random_uuid" "ses_bff_lambda_layer_uuid" {}

module "ses_lambda_layer" {
  source = "terraform-aws-modules/lambda/aws"
  version             = "4.18.0"
  create_layer        = true
  layer_name          = "${var.env}-student-essentials-layer-v1"
  compatible_runtimes = ["python3.11"]

  source_path = [
    {
      pip_requirements = "${path.module}/../requirements.txt"
      prefix_in_zip    = "python"
    }
  ]

  hash_extra = "${random_uuid.ses_bff_lambda_layer_uuid.result}"
  runtime    = "python3.11"
}