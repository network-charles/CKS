resource "aws_vpc" "k8s" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "k8s"
  }
}

resource "aws_internet_gateway" "k8s" {
    vpc_id = aws_vpc.k8s.id

  tags = {
    Name = "k8s"
  }
}

resource "aws_route_table" "k8s" {
    vpc_id = aws_vpc.k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s.id
  }

  tags = {
    Name = "k8s"
  }
}   

resource "aws_subnet" "my_subnet_1" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "my_subnet_1"
  }
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id            = aws_vpc.k8s.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "my_subnet_2"
  }
}

resource "aws_route_table_association" "k8s" {
    count = 2
    route_table_id = aws_route_table.k8s.id
    subnet_id = count.index % 2 == 0 ? aws_subnet.my_subnet_1.id : aws_subnet.my_subnet_2.id
}
