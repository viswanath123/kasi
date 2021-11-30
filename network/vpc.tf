  data "aws_availability_zones" "available" {}
  resource "aws_vpc" "my-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = "my-vpc"
  }
}
resource "aws_subnet" "my-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  
  tags = {
    Name = "my-subnet"
  }
}
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "private"
   }
   }
resource "aws_internet_gateway" "my-gw" {
    vpc_id = aws_vpc.my-vpc.id
  
    tags = {
      Name = "my-gw"
    }
  }
  resource "aws_route_table" "my-route" {
    vpc_id = aws_vpc.my-vpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.my-gw.id
    }

    tags = {
        Name = "my-route"
      }
    }
    resource "aws_route_table_association" "a" {
        subnet_id      = aws_subnet.my-subnet.id
        route_table_id = aws_route_table.my-route.id
      }
      resource "aws_security_group" "sg" {
        name        = "kasi"
        description = "Allow all inbound traffic"
        vpc_id = aws_vpc.my-vpc.id
        ingress {
          description      = "TLS from VPC"
          from_port        = 22
          to_port          = 22
          protocol         = "tcp"
          cidr_blocks      = ["0.0.0.0/0"]
        }
        egress {
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
         }
       
      }
      resource "aws_security_group" "security_private" {
        name        = "private"
        description = "Allow all inbound traffic"
        vpc_id = aws_vpc.my-vpc.id
        ingress {
          description      = "allow traffic from public server"
          from_port        = 22
          to_port          = 22
          protocol         = "tcp"
          cidr_blocks      = ["10.0.1.0/24"]
        }
        egress {
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
         }
       
      }
      
      




