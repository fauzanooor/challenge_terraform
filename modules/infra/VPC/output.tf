output "vpc_id" {
    value = aws_vpc.buburtimor_vpc.id
}

output "subnet_id_public" {
    value = aws_subnet.buburtimor_subnet_public.id
}

output "subnet_id_private_a" {
    value = aws_subnet.buburtimor_subnet_private.id
}

output "natgw_eip" {
    value = aws_eip.buburtimor_eip_natgw.public_ip
}