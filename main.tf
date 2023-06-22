module "vpc" {

  source = "git::https://github.com/RudrayyaMS/tf-module-vpc.git"


  for_each = var.vpc
}