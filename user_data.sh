#!/bin/bash

# Enable logging and debugging
exec > /var/log/user-data.log 2>&1
set -x

# Update packages and install Docker
apt update -y
apt install docker.io -y

# Start Docker service and enable on reboot
systemctl start docker
systemctl enable docker

# Add 'ubuntu' user to docker group
usermod -aG docker ubuntu

# Sleep to allow Docker to fully initialize
sleep 20

# Switch to the ubuntu home directory
cd /home/ubuntu || exit 1

# Clone your GitHub repo (if not already cloned)
if [ ! -d "DevOpsProjectEndtoEnd" ]; then
  git clone https://github.com/Sarthak-Srivastava03/DevOpsProjectEndtoEnd.git
fi

cd DevOpsProjectEndtoEnd || exit 1

# Verify that the Dockerfile and Maven project exist
if [ ! -f "Dockerfile" ]; then
  echo "Dockerfile missing!"
  exit 1
fi

# Build Docker image
docker build -t java-ec2-app .

# Check if build was successful
if [ $? -ne 0 ]; then
  echo "Docker build failed"
  exit 1
fi

# Run Docker container in detached mode
docker run -d -p 8080:8080 java-ec2-app

# Optional: output running containers for confirmation
docker ps