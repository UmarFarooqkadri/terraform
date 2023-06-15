resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = var.vpc_tags
}

# Create public subnets
resource "aws_subnet" "public" {

  count      = length(var.public_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidrs[count.index]
  availability_zone = data.aws_availability_zones.vpc_az.names[count.index]
  tags = {
    Name = "Public-${count.index +1}"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id  
}

# Create route table for public subnets
resource "aws_route_table" "public" {

    vpc_id = aws_vpc.main.id  

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

    tags = {
    Name = "Public-Route"
  }
  
}

# Create association of route table with public subnet

resource "aws_route_table_association" "public" {
  count = length(var.public_cidrs)
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.id
}