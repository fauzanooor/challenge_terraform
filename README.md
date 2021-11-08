
# challenge_terraform
This is some terraform HCL modules, for deploying Autoscaling Group in AWS

And there's few resources that related to it, which is:
1. a VPC (`aws_vpc`)
2. 2 subnets for public and private (`aws_subnet`)
3. an Internet Gateway, for connecting the VPC to internet (`aws_internet_gateway`)
4. a NAT Gateway, for connecting instances in the private subnet to internet (`aws_nat_gateway`)
5. an Elastic IP, for NAT Gateway (`aws_eip`)
6. 2 route tables for public and private (`aws_route_table`)
7. 2 route tables association, for connecting each route tables to each subnets (`aws_route_table_association`)
8. a launch template, for preparing the image to be used by ASG (`aws_launch_template`)
9. an autoscaling group or ASG (`aws_autoscaling_group`)
10.  an ASG policy for define the scaling policy (`aws_autoscaling_policy`)

# Topology
![enter image description here](https://raw.githubusercontent.com/fauzanooor/challenge_terraform/main/topology-terraform.png)

# Step 1 - Deploy the VPC
Go to ./general/dev/vpc directory, and run the `terraform init` first

I'm using my S3 bucket as my backend for storing the terraform state. For the region, I'm using ap-southeast-1 (Singapore) for all of the resources.

In here, I can specify for some important parameters for deploying the VPC and other services that direct-related to it, such as CIDR of the VPC (also for the subnet), region, and environment that will use for tagging purposes.

And also, there's some outputs after the deployment processes are completed, like IDs of VPC, subnets, and, EIP. We should keep those outputs, because there will be used in the next step.

## command
`terraform plan`

`terraform apply -auto-approve`

# Step 2 - Deploy ASG
Go to ./general/dev/services directory, and run the `terraform init` first.

For the terraform state will be store at the same bucket with VPC, but in different directory.

Here's some parameters that we can specify:

 - image_id: the ID of AMI that will used by the launch template, and we can find the ID from the AWS marketplace or create custom AMI
 - instance_type: the type of instance that will be use by the EC2
 - desired_capacity: amount of instance(s) when ASG is just deployed
 - max_size: maximum of instance(s) when the ASG scale out
 - min_size: minimum of instance(s) when the ASG is scale in
 - vpc_subnet_id: ID of the subnet that will be used by the instances, and this is refer on the previous step
 - asg_policy_name: just the name of ASG policy
 - cpu_trigger_value: amount of CPU percentage to triggering the scaling for the ASG
 - key_name: key pair that will use by the EC2 instances
 - env: just the name of environment

## command
`terraform plan`

`terraform apply -auto-approve`
