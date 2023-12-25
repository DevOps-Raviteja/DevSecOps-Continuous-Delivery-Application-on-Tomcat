# Providing AWS Provider
provider "aws" {
    region = "us-east-1"
}

# Creating AWS VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.10.0.0/16"
    tags = {Name = "my_vpc"}
}

# Creating AWS Subnet 
resource "aws_subnet" "my_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.10.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {Name = "my_subnet"}
}

# Creating AWS Internet Gateway
resource "aws_internet_gateway" "my_internet_gateway" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {Name = "my_internet_gateway"}
}

# Creating AWS Route Table
resource "aws_route_table" "my_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_internet_gateway.id
    }
    tags = {Name = "my_route_table"}
}

# Creating AWS Subnet Association Connect Subnet with Route Table
resource "aws_route_table_association" "my_route_table_association" {
    route_table_id = aws_route_table.my_route_table.id
    subnet_id = aws_subnet.my_subnet.id
}

# Creating AWS Security Group
resource "aws_security_group" "my_security_group" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {Name = "my_security_group"}
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTP"
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTP"
        from_port = 8081
        to_port = 8083
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTP"
        from_port = 9000
        to_port = 9000
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}