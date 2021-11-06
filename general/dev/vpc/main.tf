provider "aws" {
    region                  = var.region
    shared_credentials_file = "/home/fauzan/.aws/credentials"
}

terraform {
    required_version    = ">= 0.12"
    backend "s3" {
        bucket          = "s3.dev.buburtimor.xyz"
        key             = "terraform/general/dev/vpc/terraform.tfstate"
        region          = "ap-southeast-1"
    }
}

module "buburtimor_infra_vpc" {
    source = "../../../modules/infra/VPC"
    region = var.region
    env = var.env
    cidr_vpc = var.cidr_vpc
    cidr_subnet_public = var.cidr_subnet_public
    cidr_subnet_private = var.cidr_subnet_private
}

output "buburtimor_infra_vpc_details" {
    value = module.buburtimor_infra_vpc.*
}