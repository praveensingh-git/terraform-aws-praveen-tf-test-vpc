output "VPC_iD" {
  value = aws_vpc.name.id
}

locals {
  #subnet_name={id=,az=}
  public_Subnet_output = {
    for key, config in local.public_subnet : key => {
      subnet_id         = aws_subnet.name[key].id
      availability_zone = aws_subnet.name[key].availability_zone
    }
  }

}

output "public_subnet" {
  value = local.public_Subnet_output
}

