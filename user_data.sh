#!/bin/bash

# Update system and install Docker
apt update -y
apt install docker.io -y

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Add 'ubuntu' user to the docker group to avoid permission denied errors
usermod -aG docker ubuntu

# Wait for Docker service to be fully ready
sleep 10

# Navigate to the working directory
cd /home/ubuntu

# Clone your GitHub repo
git clone https://github.com/Sarthak-Srivastava03/DevOpsProjectEndtoEnd.git

# Navigate into your project directory
cd DevOpsProjectEndtoEnd

# Build the Docker image
sudo docker build -t java-ec2-app .

# Run the container
sudo docker run -d -p 8080:8080 java-ec2-app