
# instance creation
resource "aws_instance" "ec2" {
  ami                     = data.aws_ami.ami.image_id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.sg.id]
  iam_instance_profile = "${var.env}-${var.component}-role"
  tags = {
    Name = var.component
  }
}

# it will not destroy the instance and will create the route53 record
resource "null_resource" "provisioner" {

  provisioner "remote-exec" {

    connection {
      host      = aws_instance.ec2.public_ip
      user      = "centos"
      password  = "DevOps321"
    }

    inline = [
      "sudo labauto ansible",
      "ansible-pull -i localhost, -U https://github.com/RudrayyaMS/roboshop-ansible.git roboshop.yml -e role_name=${var.component}"
    ]
  }
}


# DNS record creation
resource "aws_route53_record" "record" {
  zone_id = "Z0900206KGOHOIP4AMC1"
  name    = "${var.component}-dev.devopsm71.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.ec2.private_ip]
}

# security group creation
resource "aws_security_group" "sg" {
  name        = "${var.component}-${var.env}-sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "ALL"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}

# # security group creation end

# IAM policy creation
resource "aws_iam_policy" "ssm-policy" {
  name        = "${var.env}-${var.component}-ssm"
  path        = "/"
  description = "${var.env}-${var.component}-ssm"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": "arn:aws:ssm:us-east-1:217584426072:parameter/${var.env}.${var.component}*"
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": "ssm:DescribeParameters",
        "Resource": "*"
      }
    ]
  })
}

 ## end creation policy
# attached policy  to role
## crate role

resource "aws_iam_role" "role" {
  name = "${var.env}-${var.component}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}
## end create role

#create instance policy

resource "aws_iam_instance_profile" "profile" {
  name = "${var.env}-${var.component}-role"
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.ssm-policy.arn
}