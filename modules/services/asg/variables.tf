variable "image_id" {}
variable "instance_type" {
    default = "t2.micro"
}
variable "env" {}
variable "key_name" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "vpc_subnet_id" {}
variable "asg_policy_name" {}
variable "cpu_trigger_value" {
    default = "50"
}