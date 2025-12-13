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

resource "aws_route_table_association" "teste" {
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

resource "aws_security_group_rule" "allow-all" {
  type              = "ingress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my-sg.id
}

# Creating a EC2 Instance

resource "aws_instance" "my-ec2" {
  instance_type               = "t3.micro"
  ami                         = "ami-0bddb58ec42d165f9"
  subnet_id                   = aws_subnet.my-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
 

  tags = {
    Name = "my-ec2"
  }
}

# NEXT STEP: ADD A KEY PAIR TO ESTABILISH THE SSH CONNECTION
# Creating a Security Key Pair

# resource "aws_key_pair" "my-key-pair" {
#key_name = "my-key-pair"
#public_key = ""
#}

output "ec2_public_ip" {
  value = aws_instance.my-ec2.public_ip
}

