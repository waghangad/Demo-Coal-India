# demo terraform setup
Demo resource creation using terraform

# Destroy all resources created using this terraform workspace.

~ workspace > settings > Destruction and Deletion > Queue destroy plan

# First approch install httpd at default port 80

#!/bin/bash
  echo "*** Installing apache2"
  sudo yum update -y
  sudo yum install httpd -y
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo '<body style = "background:pink"><b>This is Sample App 1</b> </body>' >> /var/www/html/index.html
  echo "*** Completed Installing apache2"

# Second approch install httpd at custom port 8080
# Also please change sg configuration

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

ingress {
    description      = "HTTP from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  https://www.hashicorp.com/blog/drift-detection-for-terraform-cloud-is-now-generally-available