variable "vpc_id" {
    type = string  
}
variable "public_subnet_id" {
    type = string
}

variable "sonar_sg_name" {
    default = "jenkins-sonar-sg"
    type = string
}

variable "controller_sg_name" {
    default = "jenkins-controller-sg"
    type = string
}

variable "agent_sg_name" {
    default = "jenkins-agent-sg"
    type = string
}

variable "instance_type" {
    default = "c7i-flex.large"
    type = string
}

variable "key_name" {
    default = "AWS-KeyPair-US-EAST-1"
    type = string
}

variable "ebs_size" {
    default = 20
    type = number
}
