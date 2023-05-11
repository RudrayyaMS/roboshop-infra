# data source
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"   # ami name
  owners           = ["973714476881"]            # ami location 1st part

}

# instance creation
resource "aws_instance" "ec2" {
  ami                     = data.aws_ami.ami.image_id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [var.sg_id]
  tags = {
    Name = var.component
  }

  provisioner "remote-exec" {

    connection {
      host      = self.public_ip
      user      = "centos"
      password  = "DevOps321"
    }

    inline = [
      "git clone https://github.com/RudrayyaMS/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${var.component}.sh"
    ]
  }
}

# DNS record creation
resource "aws_route53_record" "record" {
  zone_id = "Z0900206KGOHOIP4AMC1"
  name    = "$(var.component)-dev.devopsm71.online"
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
variable "component" {}
variable "instance_type" {}
variable "env" {
  default = "dev"
}