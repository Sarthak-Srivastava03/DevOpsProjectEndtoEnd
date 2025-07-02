#!/bin/bash

# Enable logging and debugging
exec > /var/log/user-data.log 2>&1
set -x

# Update and install required packages
apt update -y
apt install -y docker.io wget tar

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Add user to docker group
usermod -aG docker ubuntu

# Sleep to ensure Docker is ready
sleep 20

# Move to home directory
cd /home/ubuntu || exit 1

# Clone your GitHub repo if not already present
if [ ! -d "DevOpsProjectEndtoEnd" ]; then
  git clone https://github.com/Sarthak-Srivastava03/DevOpsProjectEndtoEnd.git
fi

cd DevOpsProjectEndtoEnd || exit 1

# Build Docker image
docker build -t java-ec2-app .

# If Docker build fails, exit
if [ $? -ne 0 ]; then
  echo "Docker build failed"
  exit 1
fi

# Run Spring Boot container
docker run -d -p 8080:8080 java-ec2-app

# === PROMETHEUS INSTALLATION ===
cd /opt || exit 1
wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz
tar -xvzf prometheus-2.52.0.linux-amd64.tar.gz
mv prometheus-2.52.0.linux-amd64 prometheus

# Copy Prometheus config from repo
cp /home/ubuntu/DevOpsProjectEndtoEnd/prometheus/prometheus.yml /opt/prometheus/
cp /home/ubuntu/DevOpsProjectEndtoEnd/prometheus/alerts.yml /opt/prometheus/

# Run Prometheus
cd /opt/prometheus
nohup ./prometheus --config.file=prometheus.yml > /opt/prometheus/prometheus.log 2>&1 &

# === ALERTMANAGER INSTALLATION ===
cd /opt || exit 1
wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
tar -xvzf alertmanager-0.27.0.linux-amd64.tar.gz
mv alertmanager-0.27.0.linux-amd64 alertmanager

# Copy Alertmanager config
cp /home/ubuntu/DevOpsProjectEndtoEnd/alertmanager/alertmanager.yml /opt/alertmanager/

# Run Alertmanager
cd /opt/alertmanager
nohup ./alertmanager --config.file=alertmanager.yml > /opt/alertmanager/alertmanager.log 2>&1 &

# === GRAFANA INSTALLATION ===
wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | tee /etc/apt/sources.list.d/grafana.list

apt update -y
apt install -y grafana

mkdir -p /etc/grafana/provisioning/datasources
cat <<EOF > /etc/grafana/provisioning/datasources/prometheus.yaml
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://localhost:9090
    isDefault: true
EOF

systemctl daemon-reexec
systemctl enable grafana-server
systemctl start grafana-server
