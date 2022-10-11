# demo-coal-india
Demo resource creation using terraform


#!/bin/bash
  echo "*** Installing apache2"
  sudo yum update -y
  sudo yum install httpd -y
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo 'This is Coal India PoC' >> /var/www/html/index.html
  echo "*** Completed Installing apache2"



  #!/bin/bash
  echo "*** Installing apache2"
  sudo yum update -y
  sudo yum install httpd -y
  sudo sed 's/80/8080/' /etc/httpd/conf/httpd.conf >> httpd.conf
  sudo rm -rf /etc/httpd/conf/httpd.conf
  sudo cp httpd.conf /etc/httpd/conf/
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo 'This is Coal India PoC' >> /var/www/html/index.html
  echo "*** Completed Installing apache2"