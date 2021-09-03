data "aws_availability_zones" "azs" {

}

resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public1.id
  allocation_id = aws_eip.eip.id

  tags = {
    Name = "nat"
  }
}

resource "aws_eip" "eip" {

  vpc = true

  tags = {
    Name = "eip"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "route_table_private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route_table_public"
  }
}

resource "aws_route_table_association" "private1" {
  route_table_id = aws_route_table.private.id

  subnet_id = aws_subnet.private1.id
}

resource "aws_route_table_association" "private2" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private2.id
}

resource "aws_route_table_association" "private3" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private3.id
}

resource "aws_route_table_association" "public1" {
  route_table_id = aws_route_table.public.id

  subnet_id = aws_subnet.public1.id
}

resource "aws_route_table_association" "public2" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public2.id
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.1.0/24"
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "subnet-public-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.16.2.0/24"

  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "subnet-public-2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.16.3.0/24"

  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "subnet-private-1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "172.16.4.0/24"

  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "subnet-private-2"
  }
}

resource "aws_subnet" "private3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.5.0/24"
  availability_zone = data.aws_availability_zones.azs.names[2]

  tags = {
    Name = "subnet-private-3"
  }
}

resource "aws_db_subnet_group" "mysql" {
  name       = "db-subngroup"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id, aws_subnet.private3.id]

  tags = {
    Name = "db-subnetGroup"
  }
}
