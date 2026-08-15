resource "aws_security_group" "jenkins-sg-sonarqube" {
    vpc_id = var.vpc_id
    name = var.sonar_sg_name
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 9000
        to_port = 9000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "jenkins-sg-controller" {
    vpc_id = var.vpc_id
    name = var.controller_sg_name
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "jenkins-sg-agent" {
    vpc_id = var.vpc_id
    name = var.agent_sg_name
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "aws_ami" "server_ami" {
    most_recent = true
    owners      = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}

resource "aws_instance" "ec2_dev" {
    for_each = local.instances
    instance_type          = each.value.type
    ami                    = data.aws_ami.server_ami.id
    vpc_security_group_ids = [each.value.sg]
    subnet_id              = var.public_subnet_id
    key_name               = var.key_name
    root_block_device {
        volume_size = each.value.disk
    }
    tags = {
        Name = each.key
    }
}

locals {
    instances = {
        agent = {
            sg   = aws_security_group.jenkins-sg-agent.id
            type = var.instance_type
            disk = 30
        }

        controller = {
            sg   = aws_security_group.jenkins-sg-controller.id
            type = var.instance_type
            disk = var.ebs_size
        }

        sonarqube = {
            sg   = aws_security_group.jenkins-sg-sonarqube.id
            type = var.instance_type
            disk = var.ebs_size
        }
    }
}