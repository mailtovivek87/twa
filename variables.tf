variable "region" {
  default = "us-west-2"
}

variable "amis" {
  type = "map"

  default = {
    us-west-2 = "ami-c59ce2bd"
  }

  description = "Ubuntu AMI"
}

variable "aws_access_key" {
  default     = ""
  description = "User AWS Access key"
}

variable "aws_secret_key" {
  default     = ""
  description = "User AWS Secret key"
}

variable "vpc-cidr" {
  //variable "vpc-fullcidr" {
  default     = "172.16.0.0/16"
  description = "Full VPC CIDR"
}

variable "public-subnet-cidr" {
  //variable "Subnet-Public-AzA-CIDR" {
  default     = "172.16.0.0/24"
  description = "Public Subnet CIDR"
}

variable "private-subnet-cidr" {
  //variable "Subnet-Private-AzA-CIDR" {
  default     = "172.16.1.0/24"
  description = "Private subnet CIDR"
}

variable "ssh-key" {
  //variable "key_name" {
  default     = ""
  description = "SSH key for EC2 instances"
}

variable "instance_type" {
  type = "map"

  default = {
    default = "t2.nano"
    uat     = "t2.nano"
    prod    = "t2.micro"
  }
}

variable "max_instance_count" {
  type = "map"

  default = {
    default = 3
    uat     = 3
    prod    = 10
  }
}
