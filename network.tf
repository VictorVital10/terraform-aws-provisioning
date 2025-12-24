# Creating a Virtual Private Cloud (VPC)

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

# Creating a Subnet

resource "aws_subnet" "my-subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name = "my-subnet"
  }
}

# Creating a Internet Gateway

resource "aws_internet_gateway" "my-ig" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-ig"
  }
}

# Creating a Route Table

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-ig.id
  }

  tags = {
    Name = "my-rt"
  }
}

# Associates the Subnet with the Route Table

resource "aws_route_table_association" "rt-association" {
  subnet_id      = aws_subnet.my-subnet.id
  route_table_id = aws_route_table.my-rt.id
}

# Creating a Security Group

resource "aws_security_group" "my-sg" {
  name        = "my-sg"
  description = "Practicing IAC"
  vpc_id      = aws_vpc.my-vpc.id

}

# Creating Rules for Security Group

# Allow All Outbound Traffic

resource "aws_security_group_rule" "allow-all-outbound" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  description = "Allow all outbound traffic"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my-sg.id
}

# Allow Inbound SSH Access 

resource "aws_security_group_rule" "allow-ssh22" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  description       = "Allow SSH access"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my-sg.id
}

# Allow Inbound HTTP Access

resource "aws_security_group_rule" "allow-http80" {
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  description       = "Allow HTTP access"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my-sg.id
}






