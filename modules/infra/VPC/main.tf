resource "aws_vpc" "buburtimor_vpc" {
    cidr_block              = var.cidr_vpc
    enable_dns_hostnames    = "true"
    enable_dns_support      = "true"
    
    tags        = {
        Name                = "buburtimor_vpc_${var.env}"
        ResourceGroup       = "fauzan"
        environment         = var.env
    }
}

resource "aws_subnet" "buburtimor_subnet_public" {
    cidr_block              = var.cidr_subnet_public
    vpc_id                  = aws_vpc.buburtimor_vpc.id
    availability_zone       = var.subnet_zone_pub
    
    tags        = {
        Name                = "buburtimor_subnet_pub_${var.env}"
        ResourceGroup       = "fauzan"
        environment         = var.env
    }
}

resource "aws_subnet" "buburtimor_subnet_private" {
    cidr_block              = var.cidr_subnet_private
    vpc_id                  = aws_vpc.buburtimor_vpc.id
    availability_zone       = var.subnet_zone_pri
    
    tags        = {
        Name                = "buburtimor_subnet_pri_${var.env}"
        ResourceGroup       = "fauzan"
        environment         = var.env
    }
}

resource "aws_internet_gateway" "buburtimor_igw" {
    vpc_id                  = aws_vpc.buburtimor_vpc.id

    tags        = {
        Name                = "buburtimor_igw_${var.env}"
        ResourceGroup       = "fauzan"
        environment         = var.env
    }
}

resource "aws_eip" "buburtimor_eip_natgw" {
    vpc                     = "true"

    tags        = {
        Name                = "buburtimor_eip_natgw_${var.env}"
        ResourceGroup       = "fauzan"
        environment         = var.env
    }
}

resource "aws_nat_gateway" "buburtimor_natgw" {
    allocation_id           = aws_eip.buburtimor_eip_natgw.id
    subnet_id               = aws_subnet.buburtimor_subnet_public.id
    depends_on              = [aws_internet_gateway.buburtimor_igw]

    tags        = {
        Name                = "buburtimor_natgw_${var.env}"
        ResourceGroup       = "fauzan"
        environment         = var.env
    }
}

resource "aws_route_table" "buburtimor_route_private" {
    vpc_id                  = aws_vpc.buburtimor_vpc.id

    route {
        cidr_block          = "0.0.0.0/0"
        nat_gateway_id      = aws_nat_gateway.buburtimor_natgw.id
    }

    tags        = {
        Name                = "buburtimor_route_private_${var.env}"
        ResourceGroup       = "fauzan"
        environment         = var.env
    }

}

resource "aws_route_table" "buburtimor_route_public" {
    vpc_id                  = aws_vpc.buburtimor_vpc.id

    route {
        cidr_block          = "0.0.0.0/0"
        gateway_id          = aws_internet_gateway.buburtimor_igw.id
    }

    tags        = {
        Name                = "buburtimor_route_public_${var.env}"
        ResourceGroup       = "fauzan"
        environment         = var.env
    }
}

resource "aws_route_table_association" "buburtimor_route_private_association" {
    subnet_id               = aws_subnet.buburtimor_subnet_private.id
    route_table_id          = aws_route_table.buburtimor_route_private.id
}

resource "aws_route_table_association" "buburtimor_route_public_association" {
    subnet_id               = aws_subnet.buburtimor_subnet_public.id
    route_table_id          = aws_route_table.buburtimor_route_public.id
}