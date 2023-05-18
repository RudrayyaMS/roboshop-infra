terraform {
  backend "s3" {
    bucket = "terraformm-71"
    key    = "05-s3-state/terraform.tfstate"   # file name
    region = "us-east-1"
  }
}

resource "aws_ssm_parameter" "foo" {
  name  = "foo"
  type  = "String"
  value = "bar"
}