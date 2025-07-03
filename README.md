☁️ Java Spring Boot Monitoring with Prometheus, Alertmanager & Grafana – Automated with Terraform
🚀 This end-to-end DevOps project demonstrates deploying a Java Spring Boot application on an AWS EC2 instance, containerized with Docker, and monitored using Prometheus, Alertmanager, and Grafana — fully automated using Terraform + user_data.sh.
________________________________________
📌 Tech Stack
Layer	Tools/Tech Used
IaC	Terraform (EC2 + Security Group setup)
Containerization	Docker
App	Java Spring Boot
Monitoring	Prometheus + Alertmanager
Visualization	Grafana
Email Alerts	Gmail SMTP via Alertmanager
________________________________________
🏗️ Architecture Diagram
User --> EC2 Instance (Docker + App + Prometheus + Alertmanager + Grafana)
           └── Spring Boot App → Actuator Metrics → Prometheus
           └── Prometheus Alerts → Alertmanager → Email
           └── Prometheus as Datasource → Grafana Dashboards
________________________________________
📦 Features
•	✅ Dockerized Java App deployed automatically on EC2
•	✅ Prometheus installed and scraping Spring Boot metrics
•	✅ Alertmanager sends email if app goes down
•	✅ Grafana automatically connects to Prometheus as datasource
•	✅ Full automation via user_data.sh — no manual SSH needed!
________________________________________
📂 Project Structure
DevOpsProjectEndtoEnd/
├── alertmanager/
│   └── alertmanager.yml        # Email alert config
├── prometheus/
│   ├── prometheus.yml          # Scrape configs
│   └── alerts.yml              # Alert rules
├── src/                        # Spring Boot app source
├── Dockerfile                  # Builds app image
├── user_data.sh                # EC2 boot script
└── main.tf                     # Terraform EC2 + security group
________________________________________
🚀 Deployment (One Step)
terraform init
terraform apply
This:
•	Provisions EC2
•	Clones GitHub repo
•	Builds & runs Docker app
•	Sets up Prometheus + Alertmanager + Grafana
•	Auto-connects Prometheus to Grafana as datasource
________________________________________
🔍 Accessing the Setup
Service	Port	URL Example
App (Spring Boot)	8080	http://:8080
Prometheus	9090	http://:9090
Alertmanager	9093	http://:9093
Grafana	3000	http://:3000 (default: admin/admin)
________________________________________
📬 Sample Alert Email
Subject: 🔥 Firing Alert - Spring Boot App is Down
Body: Instance localhost:8080 has been down for more than 30 seconds.
________________________________________
📸 Screenshots
Prometheus Alerts 	
 🔔 Prometheus Alerts
![Prometheus Alerts](./screenshots/prometheus_alerts.png)
	
📊 Grafana Dashboard
![Grafana Dashboard](./screenshots/grafana_dashboard.png)	
________________________________________
🙌 Author
Sarthak Srivastava
Java Backend Developer | Cloud & DevOps Enthusiast
📧 LinkedIn
________________________________________
🏋️‍♂️ Next Steps (Future Scope)
