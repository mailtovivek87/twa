INSTALLATION :
--------------
1. Clone repo :
git clone

2. Install Terraform :
    a: If using Ubuntu 14.04, follow below steps
    sudo apt-get install unzip
    wget https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip
    unzip terraform_0.11.1_linux_amd64.zip
    sudo mv terraform /usr/local/bin/

    b. For any other OS, download appropriate package from https://www.terraform.io/downloads.html

SETUP :
-------
1. Update variables.tf file before running terraform playbook with below params:
    a. aws_access_key : Update default value at #16 with your aws_access_key
    b. aws_secret_key : Update default value at #21 with your aws_secret_key
    c. ssh-key : Update value at #45 with key name available in your AWS account

RUNNING SCRIPTS AND CREATING ENV :
----------------------------------
1. Run `terraform init`
2. Run `terraform plan`
3. Create prod and uat env :
    `terraform workspace new prod`
    `terraform workspace new uat`
3. Choose env to run (replace prod with UAT, if UAT) : `terraform workspace select prod`
4. Run `terraform apply`
5. Once done, to run in a different env like in uat, just run : `terraform workspace select uat`
6. Run `terraform apply`

RUNNING SCRIPT :
----------------
install.sh script can be run to perform above steps except Step 2 where aws keys and ssh keys need to be updated first in variables.tf file.


