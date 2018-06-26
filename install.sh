#!/bin/bash

sudo apt-get update -y
sudo apt-get install unzip -y
wget https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip
unzip terraform_0.11.1_linux_amd64.zip
sudo mv terraform /usr/local/bin/

terraform init
terraform plan
terraform workspace new prod
terraform workspace new uat
terraform workspace select uat
terraform apply

