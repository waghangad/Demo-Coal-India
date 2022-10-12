terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = var.profile_name
}

# Server creation code
resource "aws_instance" "web-server-1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile = var.iam_role
  key_name = var.instance_key
  subnet_id              = aws_subnet.public_subnet1.id
  security_groups = [aws_security_group.sg.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo yum update -y
  sudo yum install httpd -y
  sudo sed 's/80/8080/' /etc/httpd/conf/httpd.conf >> httpd.conf
  sudo rm -rf /etc/httpd/conf/httpd.conf
  sudo cp httpd.conf /etc/httpd/conf/
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo 'This is Sample Application' >> /var/www/html/index.html
  echo "*** Completed Installing apache2"
  EOF

  tags = {
    Name = "web_instance_1"
  }

  volume_tags = {
    Name = "web_instance_1"
  } 
}

resource "aws_instance" "web-server-2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile = var.iam_role
  key_name = var.instance_key
  subnet_id              = aws_subnet.public_subnet2.id
  security_groups = [aws_security_group.sg.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo yum update -y
  sudo yum install httpd -y
  sudo sed 's/80/8080/' /etc/httpd/conf/httpd.conf >> httpd.conf
  sudo rm -rf /etc/httpd/conf/httpd.conf
  sudo cp httpd.conf /etc/httpd/conf/
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo 'This is Sample Application' >> /var/www/html/index.html
  echo "*** Completed Installing apache2"
  EOF

  tags = {
    Name = "web_instance_2"
  }

  volume_tags = {
    Name = "web_instance_2"
  } 
}

# AWS Loadbalancer creation code
resource "aws_lb" "web-app-alb" {
  name               = "web-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [public_subnet1,public_subnet2]
}