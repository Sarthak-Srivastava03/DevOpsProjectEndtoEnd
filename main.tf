provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_app" {
  ami           = "ami-0f58b397bc5c1f2e8"   # Ubuntu 22.04 (Mumbai)
  instance_type = "t2.micro"
  key_name      = "projectKey"  # Your .pem key name

  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "Terraform-Docker-App"
  }
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
