# Jummpv_Terraform

### AWS Infrastructure of JumpV

## Introduction

This Terraform Project uses AWS Resources to create EC2 instances, Auto Scaling group, Launch Template, Load Balancer, S3 bucket,Cloud-front, Route 53, Internet gateway, Subnet, RDS Databas.

## There are following terraform file in this repo: 

which is following:

## (1) ELB.tf: 

(i) resource “aws_lb”: create application load balancer.

(ii) resource “aws_lb_target_group”: this resource group creates an Amazon Web Services (AWS) Application Load Balancer (ALB) target group resource. The target group is named "jumpv-tg" and is configured to listen on port 80 using the HTTP protocol.  

(iii) resource “aws_lb_target_group_attachment”: This is a resource of a Terraform configuration file that creates an Amazon Web Services (AWS) Application Load Balancer (ALB) target group attachment resource.
This configuration file allows the instance to receive traffic from the ALB through the target group.

(iv) resource “aws_lb_listener”: By creating this listener resource, the ALB is configured to receive incoming traffic on port 80 and forward it to the target group.

## (2) instance.tf:

(i) resource “aws_instance”: this resource group is used to create an instance which os: ubuntu 20.04 LTS. Ansible Playbook run on the instance.

(ii) ebs_block_device: as per now I am taking dump of database & importing it on the same machine so this block is used to increase the storage of the machine.

(iii) output “instance_public_ip”: this resource is used to give instance ip in the output.


## (3) ansible.tf

## when you run ansible playbook locally:

(i) null_resource: It is used to copy instance_id, automatically it is pasted in the ansible-playbook.

(ii) null_resource: it is used to copy the host which is created by Terraform & paste it in ansible-playbook.

(iii) null_resource: this resource is used to run the ansible-playbook.

## when you run ansible playbook on the managment server xx.xx.xx.xx:

(i) resource “null_resource”: this resource group is used to copy the host of standby instance to the ansible_host file.

(ii) resource “null_resource”: this resource group is used to copy the host of standby server to the ansible-playbook.

(iii)resource “null_resource”: this block is used to run the ansible playbook.

## (4) rds.tf 

(i) resource “aws_db_instance”: This resource group is used to create a database.


## (5) igw.tf

(i)  resource “aws_internet_gateway”: This resource group is used to creates an Amazon VPC internet gateway resource. 

(ii) resource “aws_route_table”: This resource group is used to that creates an Amazon VPC route table resource.

(iii) resource “aws_route_table_association”: This resource group is used to creates an Amazon VPC route table association resource. 

## (6) provider.tf

provider block is used in which region & account we want to create the infrastructure.

## (7) vpc.tf

(i) resource “aws_vpc”: To create vpc in aws.

(ii)  resource “aws_route_table”: This resource group is used to creates an Amazon VPC route table resource.

(iii) resource “aws_subnet”: This resource group is used to create subnet in aws console.

##(5) sg.tf

(i) resource “aws_security_group”: This resource group is used to give access to port for incoming & outgoing traffic.


## Run terraform on local machine:


## Prerequisite

1. Terraform should be installed in your local machine.

2. you should have "jumpv" key

3. Ansible should be installed in your local machine.


## Some Changes before initiating terraform code:

1. Clone this repository
    git clone https://github.com/mdamirhasan/jumpv_Terraform.git
    
2. Clone ansible repository
    git clone https://github.com/mdamirhasan/jumpv_Ansible.git

3. Change path of key in instance.tf in line no. 3:
https://github.com/mdamirhasan/jumpv_Terraform.git)

4. Change path in line no. 12,26 & 41 in ansible.tf [ The path should be change where you clone your Ansible playbook & "jumpv_key"]
https://github.com/mdamirhasan/jumpv_Terraform.git

## Following is the steps to run the script:

 ## Initilize the terraform

     terraform init

## If you want to check what is going to execute:
   
      terraform plan

 ## Create the infrastructure:

      terraform apply
      
## Manual Work:

(i). In the folder name extra I stored two files ( Django-settings-fo-JumpV.txt and WSGI-config-for-JumpV.txt )
Please copy Django-settings-fo-JumpV.txt and pase in setting.py file and 
Django-settings-for-JumpV.txt and paste in wsgi.py.


## That's all Thank You 