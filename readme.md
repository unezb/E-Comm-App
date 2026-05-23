# Static App Deployment on AWS EC2 with Docker Compose, Prometheus, and Grafana

## Project Overview

This project demonstrates how to deploy a static application on an AWS EC2 instance using Docker Compose, while also setting up monitoring with Prometheus and Grafana.

The deployment workflow includes:

* Hosting a static application on EC2
* Using Docker and Docker Compose for container orchestration
* Using Jenkins for building and deploying the containers
* Managing configuration files from GitHub
* Installing and configuring Prometheus
* Connecting Prometheus to Grafana
* Building dashboards for infrastructure monitoring
* Monitoring CPU and memory metrics

---

# Architecture

GitHub Repository
        |
        v
AWS EC2 Instance
        |
    Jenkins
        |    
        +----------------+
        | Docker Compose |
        +----------------+
          |      |      |
          |      |      |
          v      v      v
      Static   Prometheus   Grafana
        App

---

# Technologies Used

* AWS EC2
* Docker
* Docker Compose
* Prometheus
* Grafana
* Node Exporter
* GitHub
* Jenkins
* Terraform

---

# Deployment Workflow

* The EC2 instance is to be provisioned using terraform. The relevant ports are opened for future access in the security group's TF code itself.
* The application is then dockerized locally to test the application functionality. The Dockerfile is used to create the image and docker-compose will be used to orchestrate the application on EC2.
* Two DockerHub repositories are created, one public for dev repo and the other private for prod repo.
* The script to build and push the image to DockerHub is written. The deployment script is written to create a new a app directory on EC2, pull the image from DockerHub & use docker-compose to start the container.
* Jenkinsfile is created with appropriate stages to build and deploy the application for both dev and prod stages. Jenkins Webhook is configured for the GitHub repository.
* Jenkins & Docker is installed on the EC2. Jenkins mulitbranch pipeline is created with branch source as GitHub and proper script path is configure in the pipeline. 
* These files are pushed to GitHub repo. A new dev branch is created. The pipeline is triggered by the push event and the pipeline is successfully executed. The DockerHub dev repo received the pushed image. 
* On EC2, the container is up & running. The public IP is accessed on port 80 to access the application.
* The dev branch is merged with the main branch. The pipeline is again triggered by the push event and executed successfully. The prod repo received the pushed image and a docker container spun up on the EC2 machine.
* The docker-compose file is created for pulling and running the Prometheus & Grafana image. Prometheus' yaml file is configured to scrape metrics periodically. 
* The docker-compose file is pulled from the GitHub repo and deployed to EC2 manually. The Prometheus data source is configured. A node-exporter dashboard is imported in Grafana
* The public IP with respective ports is accessed to access Prometheus & Grafana dashboards. The system metrics including CPU & memory utilization can be now monitored.


# Start the Stack

```bash
docker-compose up -d
```

Verify running containers:

```bash
docker ps
```

---

# Access Services

| Service    | URL                           |
| ---------- | ----------------------------- |
| Static App | `http://<EC2_PUBLIC_IP>:80`      |
| Prometheus | `http://<EC2_PUBLIC_IP>:9090` |
| Grafana    | `http://<EC2_PUBLIC_IP>:3000` |

---

# Grafana Setup

## Default Login

```text
Username: admin
Password: admin
```

Change password after first login.

---

## Add Prometheus Data Source

1. Open Grafana
2. Go to:

```text
Connections → Data Sources → Add Data Source
```

3. Select:

```text
Prometheus
```

4. URL:

```text
http://prometheus:9090
```

5. Save & Test

---