provider "aws" {
  region = var.aws_region
}

# --- Virtual Private Cloud (VPC) para Zero-Trust ---
resource "aws_vpc" "fintech_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name        = "Sovern-VPC"
    Environment = "Production"
  }
}

# --- Strict Security Groups (Firewalls) ---
resource "aws_security_group" "api_gateway_sg" {
  name        = "sovern_api_gateway_sg"
  description = "Default Deny: Only allow inbound HTTPS and limited SSH"
  vpc_id      = aws_vpc.fintech_vpc.id

  ingress {
    description = "Allow strict HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow restricted SSH from Admin IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- Application Server ---
resource "aws_instance" "stack_node" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS 
  instance_type = "t3.medium"
  
  vpc_security_group_ids = [aws_security_group.api_gateway_sg.id]
  
  tags = {
    Name = "VeriStack-Primary-Node"
    Role = "Docker-Host"
  }
}
