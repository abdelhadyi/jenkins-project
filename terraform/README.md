# Terraform AWS Infrastructure

Simple Terraform project to provision AWS infrastructure using two modules:

* **VPC module** – creates the VPC and networking resources.
* **EC2 module** – creates EC2 instances inside the VPC.

## Structure

```text
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
```

## Usage

Initialize Terraform:

```bash
terraform init
```

Review the infrastructure:

```bash
terraform plan
```

Create the infrastructure:

```bash
terraform apply
```

To destroy the infrastructure:

```bash
terraform destroy
```

> Make sure your AWS credentials are configured before running Terraform.
