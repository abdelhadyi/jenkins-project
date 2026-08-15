module "vpc" {
    source = "./vpc"
    vpc_name = "jenkins_project_vpc"
    cidr_block = "10.0.0.0/16"
    public_subnet = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    public_subnet_name = "jenkins-public-subnet"
    public_rt = "jenkins_public_route_table"
  
}

module "EC2" {
    source = "./EC2"
    public_subnet_id = module.vpc.public_subnet_id
    vpc_id = module.vpc.vpc_id
    instance_type = "c7i-flex.large"
  
}