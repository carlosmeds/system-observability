# System Observability

This project implements observability in a simple Python application, using Terraform, Grafana, Prometheus, Loki, Jaeger and Thanos.

## 🚀 Getting Started

These instructions will allow you to obtain a copy of the project running on your local machine or on AWS.

Check **[Deployment](#-deployment)** to learn how to deploy the project.

### 📋 Prerequisites

What do you need to install the software

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/) configured with your credentials
- [S3](https://docs.aws.amazon.com/s3/) if you want to use Thanos, please create a bucket


### 📦 Deployment

1. Clone the repository:

```sh
git clone https://github.com/carlosmeds/system-observability.git
cd system-observability
```

2. Configure the AWS environment variables using [aws configure](https://docs.aws.amazon.com/cli/latest/reference/configure/)

```bash
aws configure
```

3. Rename the file [`.env.example`](./.env.example) to `.env`:

```bash
cp .env.example .env
```

4. Start the Docker services

```sh
cd observability
docker compose up --build -d
```

5. Create file terraform.tfvars (if you want to use AWS)

6. Initialize and apply the Terraform configurations:

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
* [Terraform](https://www.terraform.io/) - Infra As Code
* [Thanos](https://thanos.io/) - Prometheus setup 