# System Observability

This project implements observability in a simple Python application, using tools such as Grafana, Prometheus, Loki, and Jaeger.

## 🚀 Getting Started

These instructions will allow you to obtain a copy of the project running on your local machine or on AWS.

Check **[Deployment](#-deployment)** to learn how to deploy the project.

### 📋 Prerequisites

What do you need to install the software

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/) configured with your credentials


### 📦 Deployment

1. Clone the repository:

```sh
git clone https://github.com/carlosmeds/system-observability.git
cd system-observability
```

2. Configure the AWS environment variables using [aws configure](https://docs.aws.amazon.com/cli/latest/reference/configure/)

3. Start the Docker services

```sh
cd observability
docker compose up --build -d
```

4. Initialize and apply the Terraform configurations (if you want to use AWS):

```sh
cd ../infra
terraform init
terraform apply
```

### 🛠️ Built with

* [Flask](https://flask.palletsprojects.com/en/3.0.x/) - The web framework used in Python
* [Prometheus](https://prometheus.io/) - Monitoring and alerting system
* [Grafana](https://grafana.com/) - Analysis and monitoring platform
* [Loki](https://grafana.com/oss/loki/) - Logging system
* [Jaeger](https://www.jaegertracing.io/) - Distributed tracing system