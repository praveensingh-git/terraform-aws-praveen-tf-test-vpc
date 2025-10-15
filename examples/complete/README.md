## USAGE
```bash
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
      public     = true #to set subnet public, else private by default
    }
    public_subnet-2 = {
      cidr_block = "10.0.1.0/24"
      AZ         = "eu-north-1a"
      public     = true
    }
    private_subnet-1 = {
      cidr_block = "10.0.2.0/24"
      AZ         = "eu-north-1b"
    }
  }

}
```