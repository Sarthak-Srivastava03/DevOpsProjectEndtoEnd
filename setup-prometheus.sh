#!/bin/bash
# Install Prometheus
cd /opt
wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz
tar -xvzf prometheus-2.52.0.linux-amd64.tar.gz
mv prometheus-2.52.0.linux-amd64 prometheus


# Copy Prometheus config
if [ -f ~/DevOpsProjectEndtoEnd/prometheus/prometheus.yml ]; then
  cp ~/DevOpsProjectEndtoEnd/prometheus/prometheus.yml /opt/prometheus/
else
  echo "❌ prometheus.yml not found"
fi

# Copy alerts.yml with a check
if [ -f ~/DevOpsProjectEndtoEnd/prometheus/alerts.yml ]; then
  cp ~/DevOpsProjectEndtoEnd/prometheus/alerts.yml /opt/prometheus/
else
  echo "❌ alerts.yml not found — check repo sync timing or git clone status"
fi


# Run Prometheus
cd /opt/prometheus
nohup ./prometheus --config.file=prometheus.yml > prometheus.log 2>&1 &

# Install Alertmanager
cd /opt
wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
tar -xvzf alertmanager-0.27.0.linux-amd64.tar.gz
mv alertmanager-0.27.0.linux-amd64 alertmanager

# Copy Alertmanager config
cp ~/DevOpsProjectEndtoEnd/alertmanager/alertmanager.yml /opt/alertmanager/

# Run Alertmanager
cd /opt/alertmanager
nohup ./alertmanager --config.file=alertmanager.yml > alertmanager.log 2>&1 &
