provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "grafana_app" {
  ami           = "ami-0f58b397bc5c1f2e8"   # Ubuntu 22.04 (Mumbai)
  instance_type = "t2.micro"
  key_name      = "projectKey"  # Your .pem key name

  vpc_security_group_ids = [aws_security_group.allow_ssh_http_prometheus_grafana.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "Java-Docker-Monitoring-Automated-App with Grafana Integration"
  }
}

resource "aws_security_group" "allow_ssh_http_prometheus_grafana" {
  name        = "allow_ssh_http_prometheus_grafana_sg"
  description = "Allow SSH and HTTP and Prometheus and Alertmanager access"

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

  # Prometheus (9090)
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Alertmanager (9093)
  ingress {
    from_port   = 9093
    to_port     = 9093
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
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
