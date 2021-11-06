variable "region" {}
variable "env" {}

variable "cidr_vpc" {}
variable "cidr_subnet_public" {}
variable "cidr_subnet_private" {}
variable "subnet_zone_pub" {
    default = "ap-southeast-1a"
}
variable "subnet_zone_pri" {
    default = "ap-southeast-1a"
}