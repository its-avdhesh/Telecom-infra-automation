############################################
# IAM Role for EC2 (ECR Read Access)
############################################

resource "aws_iam_role" "ec2_role" {
  name = "telecom-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_read_only" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "telecom-ec2-profile"
  role = aws_iam_role.ec2_role.name
}



############################################
# AWS Provider Configuration
############################################

provider "aws" {
  region = "eu-north-1"
}

############################################
# Ubuntu AMI Data Source
############################################

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical (official Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

############################################
# Security Group
############################################

resource "aws_security_group" "telecom_sg" {
  name        = "telecom-sg"
  description = "Allow SSH and App traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow App Port"
    from_port   = 3002
    to_port     = 3002
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "telecom-sg"
  }
}

############################################
# EC2 Instance
############################################

resource "aws_instance" "telecom_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name               = "telecom-key"
  vpc_security_group_ids = [aws_security_group.telecom_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = file("user_data.sh")

  tags = {
    Name = "telecom-server"
  }
}


############################################
# Output Public IP
############################################

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.telecom_server.public_ip
}

