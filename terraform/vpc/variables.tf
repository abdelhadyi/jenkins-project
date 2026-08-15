variable "vpc_name" {
    default = "jenkins_project_vpc"
    type = string
}

variable "cidr_block" {
    default = "10.0.0.0/16"
    type = string
}

variable "public_subnet" {
    default = "10.0.1.0/24"
    type = string
}

variable "availability_zone" {
    default = "us-east-1a"
    type = string
}

variable "public_subnet_name" {
    default = "jenkins-public-subnet"
    type = string
}

variable "igw" {
    default = "jenkins-igw"
    type = string
}

variable "public_rt" {
    default = "jenkins_public_route_table"
    type = string
}



