provider "aws" {
    region                  = var.region
    shared_credentials_file = "/home/fauzan/.aws/credentials"
}

terraform {
    required_version    = ">= 0.12"
    backend "s3" {
        bucket          = "s3.dev.buburtimor.xyz"
        key             = "terraform/general/dev/services/terraform.tfstate"
        region          = "ap-southeast-1"
    }
}

module "buburtimor_services" {
    source = "../../../modules/services/asg"
    image_id = var.image_id
    instance_type = var.instance_type
    desired_capacity = var.desired_capacity
    max_size = var.max_size
    min_size = var.min_size
    vpc_subnet_id = var.vpc_subnet_id
    asg_policy_name = var.asg_policy_name
    cpu_trigger_value = var.cpu_trigger_value
    key_name = var.key_name
    env = var.env
}