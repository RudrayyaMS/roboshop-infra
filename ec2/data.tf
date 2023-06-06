data "aws_caller_identity" "current" {}

# data source
data "aws_ami" "ami" {
  most_recent      = true
    ## using Raghu's image
  name_regex  = "Centos-8-DevOps-Practice"   #devops-practice-with-ansible
  owners      = ["973714476881"]              #[dara.aws_caller_identity.current.account_id]
}