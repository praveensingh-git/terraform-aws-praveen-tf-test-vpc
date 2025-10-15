resource "aws_vpc" "name" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = var.vpc_config.Name
  }
}
resource "aws_subnet" "name" {
  vpc_id            = aws_vpc.name.id
  for_each          = var.subnet_Config
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.AZ
  tags = {
    Name = "${var.vpc_config.Name}-${each.key}"
  }
}

locals {
  public_subnet = {
    #key={} if public is true in subnet Config
    for key, config in var.subnet_Config : key => config if config.public
  }
}

#igw, if there is atleast one public subnet
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id
  count  = length(local.public_subnet) > 0 ? 1 : 0
  tags = {
    Name = "test_aws_igw"
  }
}

#routing table
resource "aws_route_table" "name" {
  vpc_id = aws_vpc.name.id
  count  = length(local.public_subnet) > 0 ? 1 : 0

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name[0].id
  }
}


resource "aws_route_table_association" "name" {
    for_each = local.public_subnet #public_Subnet={} private_subnet={}
  route_table_id = aws_route_table.name[0].id
  subnet_id = aws_subnet.name[each.key].id
}