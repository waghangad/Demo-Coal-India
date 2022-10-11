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

# Create a VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "app-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "vpc_igw"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.public_subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.public_subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"

  tags = {
    Name = "public-subnet-1b"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_asso_1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_asso_2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_instance" "web" {
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
  sudo yum install apache2 -y
  echo "*** Completed Installing apache2"
  EOF

  tags = {
    Name = "web_instance"
  }

  volume_tags = {
    Name = "web_instance"
  } 
}

