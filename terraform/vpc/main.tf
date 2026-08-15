resource "aws_vpc" "jenkins" {
    cidr_block           = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.jenkins.id
    cidr_block              = var.cidr_block
    map_public_ip_on_launch = true
    availability_zone       = var.availability_zone
    tags = {
        Name = var.public_subnet_name
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.jenkins.id
    tags = {
        Name = var.igw
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.jenkins.id
    tags = {
        Name = var.public_rt
    }
}

resource "aws_route" "route" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "rt_association" {
    route_table_id = aws_route_table.public_rt.id
    subnet_id = aws_subnet.public_subnet.id
}

