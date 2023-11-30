############# Declaring the data source #############
data "aws_availability_zones" "available" {
  state = "available"
}

############# Vpc creation #############

resource "aws_vpc" "main_vpc" {
  enable_dns_hostnames = true
  cidr_block           = var.cidr_block
  tags = {
    Name = "Main_Vpc"
  }
}

############# Subnet Creatione #############

resource "aws_subnet" "public" {
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = var.public_subnet_name[count.index]
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = var.private_subnet_name[count.index]
  }
}

############# Gateway creation #############

resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Internet_Gateway"
  }
}

resource "aws_eip" "nat" {

}

resource "aws_nat_gateway" "privat_natgw" {
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.nat.id
  tags = {
    Name = "Nat_Gateway"
  }

  depends_on = [aws_internet_gateway.public_igw]
}

########### Route Table ###########

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_igw.id
  }

  tags = {
    Name = "Public_Route"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.privat_natgw.id
  }

  tags = {
    Name = "Private_Route"
  }
}

########### Route Table Association ###########

resource "aws_route_table_association" "public_association" {
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_association" {
  count          = length(var.private_subnet)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
