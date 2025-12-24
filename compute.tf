# Fetching the most recent Ubuntu AMI

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
}

# Adding a Public Key Pair

resource "aws_key_pair" "my-nginx-key-pair" {
  key_name   = "nginx-key-pair"
  public_key = file("C:/Users/vitas/.ssh/My-Nginx-KP/deployer-pub-key")
}


# Creating a EC2 Instance

resource "aws_instance" "nginx-server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.aws_instance_type
  subnet_id                   = aws_subnet.my-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  key_name                    = aws_key_pair.my-nginx-key-pair.key_name


  tags = {
    Name         = "nginx-server"
    ManagedBy    = "Terraform"
    CreationDate = "24-12-2025"
  }
}


