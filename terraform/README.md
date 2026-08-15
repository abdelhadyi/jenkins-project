Terraform AWS Infrastructure

VPC module – creates the VPC and networking resources.
EC2 module – creates EC2 instances inside the VPC.

Structure
.
├── main.tf
├── variables.tf
├── vpc/
│   ├── main.tf
│   └── variables.tf
├── EC2/ 
|    ├── main.tf │ 
|    └── variables.tf
└── README.md
Usage

Initialize Terraform:

terraform init

Review the infrastructure:

terraform plan

Create the infrastructure:

terraform apply

To destroy the infrastructure:

terraform destroy
