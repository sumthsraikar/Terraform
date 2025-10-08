
provider "aws" {
  region = "us-east-1"   # Change to your preferred region
}

#default vpc
data "aws_vpc" "default" {
  default = true
}

#security group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  # Inbound rules
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules
  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}

#ec2 instance
resource "aws_instance" "web" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (update per region)
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = data.aws_vpc.default.default_subnet_id
  key_name               = "my-key"  # Replace with your existing key pair

  tags = {
    Name = "Terraform-EC2"
  }
}
