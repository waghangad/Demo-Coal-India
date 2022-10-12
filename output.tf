output "web_instance_ip" {
    value = aws_instance.web-server-2.public_ip
}