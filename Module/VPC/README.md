#  AWS VPC Terraform Module

## Overview

This Terraform project provisions a **custom AWS Virtual Private Cloud (VPC)** with configurable public and private subnets.  
The setup is modular, making it reusable and easy to maintain.

The configuration is organized into:

- **Root module:** Manages overall setup and calls submodules.
- **VPC submodule:** Handles VPC, subnets, and related networking resources.

---

##  Features

-  **VPC Creation** — Automatically creates a custom VPC with user-defined CIDR block.
-  **Public and Private Subnets** — Supports multiple public and private subnets across availability zones.

-  **Modular Design** — Uses Terraform modules for reusability and scalability.
-  **Custom Configuration** — Accepts parameters for VPC and subnet CIDR blocks, AZs, and naming.
-  **Output Variables** — Exposes VPC ID and subnet IDs for integration with other modules.

---

## Usage

### 1️ Prerequisites

- Install [Terraform](https://developer.hashicorp.com/terraform/downloads) v1.0 or later  
- AWS account with programmatic access  
- Configure your AWS CLI or environment variables with credentials  

### 2️ Clone the Repository

```bash
git clone <your-repo-url>
cd <your-repo-folder>
```

### 3️ Initialize Terraform

```bash
terraform init
```
This command initializes the working directory and downloads the required AWS provider and modules.

### 4️ Validate Configuration

```bash
terraform validate
```
Ensures the configuration syntax is correct.

### 5️ Plan the Infrastructure

```bash
terraform plan
```
Displays the changes Terraform will make in AWS before applying.

### 6️ Apply the Configuration

```bash
terraform apply
```
Creates the VPC and subnets in your AWS account.

### 7️ View Outputs

```bash
terraform output
```
You’ll see:

- `vpc_id` — The ID of the created VPC  
- `subnet_id` — The IDs of public subnets  

---

##  Project Structure

```
├── versions.tf        # Specifies Terraform version and AWS provider
├── root-main.tf       # Main file that calls the VPC module
├── root-output.tf     # Outputs for VPC ID and subnet IDs
├── Module/
│   └── VPC/
│       ├── main.tf        # Defines resources for VPC and subnets
│       ├── variables.tf   # Input variables for VPC and subnets
│       └── output.tf      # Outputs from the VPC module
├──examples/
        └──complete
                ├──main.tf
                ├──output.tf
                
```

---

##  Example Configuration

```hcl
module "vpc_module" {
  source = "./Module/VPC"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    Name       = "testing_vpc"
  }

  subnet_Config = {
    public_subnet-1 = {
      cidr_block = "10.0.0.0/24"
      AZ         = "eu-north-1a"
      public     = true
    }
    public_subnet-2 = {
      cidr_block = "10.0.1.0/24"
      AZ         = "eu-north-1c"
      public     = true
    }
    private_subnet-1 = {
      cidr_block = "10.0.2.0/24"
      AZ         = "eu-north-1b"
    }
  }
}
```

---

##  Cleanup

To remove all resources created by this configuration:

```bash
terraform destroy
```

---
