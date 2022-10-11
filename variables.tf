variable "region" {
default = "ap-south-1"
}
variable "instance_type" {
default = "t2.micro"
}
variable "ami_id" {
default = "ami-01216e7612243e0ef"
}
variable "profile_name" {
default = "default"
}
variable "instance_key" {
default = "demo-key-pair"
}
variable "vpc_cidr" {
default = "178.0.0.0/16"
}
variable "public_subnet1_cidr" {
default = "178.0.10.0/24"
}
variable "public_subnet2_cidr" {
default = "178.0.20.0/24"
}