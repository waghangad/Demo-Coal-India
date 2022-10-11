# demo-coal-india
Demo resource creation using terraform
This is created fo PoC purpose.

Following points which we need to demonstrate.

1. To demonstrate Infrastructure-as-a-Code capability through implementing a load balancer over 2 VMs and service over port 80, for a web server test page.
2. Demonstrate CI/CD by changing parameters of above script in Dev  and replicating change to production(change port 80 to 8080).
3. Perform automated Testing(simple check for permitted instances in prod) before replication from Dev to Prod.
4. Change Parameters of VM configuration in prod and show alerts raised through Drift Detection.
5. Propose approach to Scalability(to address higher load on the web server). 
6. DR [appropriate DR strategy for the above use case adhering to the prescribed RTO and RPO given in MSP Scope Activity V-Onetime Implementation]

# First approch install httpd at default port 80

#!/bin/bash
  echo "*** Installing apache2"
  sudo yum update -y
  sudo yum install httpd -y
  sudo systemctl start httpd
  sudo systemctl enable httpd
  echo 'This is Coal India PoC' >> /var/www/html/index.html
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
  echo 'This is Coal India PoC' >> /var/www/html/index.html
  echo "*** Completed Installing apache2"


  https://www.hashicorp.com/blog/drift-detection-for-terraform-cloud-is-now-generally-available