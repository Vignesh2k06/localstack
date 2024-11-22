variable "env" {
  default = "dev"
}

variable "deployment" {
  default = "develop"
}

variable "region" {
  default = "us-east-1"
}

variable "s3_bucket_name" {
  default = "localstack-test-bucket-v1"
}

locals {
  module = "${replace(path.module, "\\", "/")}"
}

variable "is_pipeline" {
  type    = bool
  default = false
}