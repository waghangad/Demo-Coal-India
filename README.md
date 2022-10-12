# demo terraform setup
  Demo resource creation using terraform

# Destroy all resources created using this terraform workspace.

  ~ workspace -> settings -> Destruction and Deletion -> Queue destroy plan

# Drift Detection.

  1. Run vpcwithsubnet cloudformation template and create resources.
  2. After stack completed under stack action select detect drift.
  3. Change some parameters of any resources created using this stack.
  3. View drift result.

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

  #!/bin/bash
  echo "*** Installing apache2"
  sudo yum update -y
  sudo yum install httpd -y
  sudo sed 's/80/8080/' /etc/httpd/conf/httpd.conf >> httpd.conf
  sudo rm -rf /etc/httpd/conf/httpd.conf
  sudo cp httpd.conf /etc/httpd/conf/
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo '<body style = "background:pink"><h1>This is Coal India Sample App 2</h1> </body>' >> /var/www/html/index.html
  echo "*** Completed Installing apache2"

  https://www.hashicorp.com/blog/drift-detection-for-terraform-cloud-is-now-generally-available