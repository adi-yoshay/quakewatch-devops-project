# QuakeWatch – DevOps Final Course Project
Phase 1: Docker · Phase 2: Kubernetes · Phase 3: Helm + CI/CD + GitOps

QuakeWatch is a Python Flask application that displays real-time and historical earthquake data using the USGS Earthquake API.
This project demonstrates containerization (Phase 1), Kubernetes deployment (Phase 2), and Helm + CI/CD + GitOps automation (Phase 3).

------------------------------------------------------------
Project Features
- Flask-based web application
- Real-time + historical earthquake statistics
- Interactive Matplotlib graphs (Agg backend)
- REST endpoints (health, status, raw data)
- Bootstrap UI
- Docker containerization
- Full Kubernetes deployment:
  - Deployment
  - Service (NodePort)
  - Liveness + Readiness probes
  - ConfigMap + Secret
  - CronJob health check
  - Horizontal Pod Autoscaler (HPA)
- Helm chart packaging
- GitHub Actions CI/CD pipelines
- GitOps automation using ArgoCD

------------------------------------------------------------
Phase 1 – Docker

Docker Hub Image:
docker pull adiyoshay681/quakewatch:latest

Run locally:
docker run -p 5000:5000 adiyoshay681/quakewatch:latest

App URL:
http://localhost:5000

------------------------------------------------------------
Build the Docker Image Locally:
docker build -t quakewatch:latest .

------------------------------------------------------------
Run with Docker:
docker run -p 5000:5000 quakewatch:latest

------------------------------------------------------------
Run with Docker Compose:

docker-compose.yml:

version: "3.9"

services:
  quakewatch:
    build: .
    container_name: quakewatch_app
    ports:
      - "5000:5000"
    volumes:
      - ./logs:/app/logs
    restart: unless-stopped

Run:
docker compose up --build

Stop:
docker compose down

------------------------------------------------------------
Phase 2 – Kubernetes Deployment

Kubernetes manifests included:
- quakewatch-deployment.yaml
- quakewatch-service.yaml
- quakewatch-configmap.yaml
- quakewatch-secret.yaml
- quakewatch-cronjob.yaml
- quakewatch-hpa.yaml

------------------------------------------------------------
1. Verify Kubernetes is Running (Docker Desktop)

kubectl get nodes

Expected:
docker-desktop   Ready

------------------------------------------------------------
2. Apply ConfigMap:
kubectl apply -f quakewatch-configmap.yaml

------------------------------------------------------------
3. Apply Secret:
kubectl apply -f quakewatch-secret.yaml

------------------------------------------------------------
4. Deploy Application (Deployment + Probes + Env Vars)

kubectl apply -f quakewatch-deployment.yaml
kubectl rollout status deployment/quakewatch-deployment
kubectl get pods

------------------------------------------------------------
5. Expose Application with NodePort Service

kubectl apply -f quakewatch-service.yaml
kubectl get svc

Access the app:
http://localhost:<NodePort>

Example:
http://localhost:30080

------------------------------------------------------------
6. CronJob – Internal Health Checking

kubectl apply -f quakewatch-cronjob.yaml
kubectl get cronjobs
kubectl get pods

A Completed CronJob pod will appear every minute.

------------------------------------------------------------
7. Horizontal Pod Autoscaler (HPA)

kubectl apply -f quakewatch-hpa.yaml
kubectl get hpa

Expected example:
quakewatch-hpa   Deployment/quakewatch-deployment   cpu: 0%/50%   2   5   2   <age>

------------------------------------------------------------
8. Validate ConfigMap & Secret Inside Pod

Find pod:
kubectl get pods

Check values:
kubectl exec -it <pod> -- printenv | grep APP_MESSAGE
kubectl exec -it <pod> -- printenv | grep SECRET_TOKEN

Expected:
APP_MESSAGE=Hello from ConfigMap
SECRET_TOKEN=my-super-secret-token

------------------------------------------------------------
Phase 3 – Helm, CI/CD & GitOps

1. Helm Chart Packaging

Package the chart:
helm package helm/quakewatch

Result:
quakewatch-0.1.0.tgz

------------------------------------------------------------
2. Push Helm Chart to DockerHub (OCI Registry)

docker login
helm push quakewatch-0.1.0.tgz oci://registry-1.docker.io/adiyoshay681

------------------------------------------------------------
3. Install or Upgrade the Chart in Kubernetes

helm upgrade --install quakewatch \
  oci://registry-1.docker.io/adiyoshay681/quakewatch \
  --version 0.1.0

Check:
kubectl get pods
kubectl get svc

------------------------------------------------------------
4. GitHub Repository Structure

https://github.com/adi-yoshay/quakewatch-devops-project

Repository includes:
- Application source code
- Dockerfile
- Kubernetes manifests
- Helm chart
- GitHub Actions workflows

Branching Strategy:
- main → protected branch (CD pipeline runs here)
- feature/* → development branches (CI pipeline runs here)

------------------------------------------------------------
5. GitHub Actions – CI Pipeline (Runs on feature branches)

Pipeline tasks:
- Install Python
- Install dependencies
- Run pylint
- Build Docker image (NOT pushed)

Trigger:
on: push to any non-main branch

------------------------------------------------------------
6. GitHub Actions – CD Pipeline (Runs on main branch)

Pipeline tasks:
- Login to DockerHub
- Build Docker image
- Tag and push to DockerHub
- Optionally update Helm chart image tag
- ArgoCD automatically deploys updates

Trigger:
on: push to main

------------------------------------------------------------
7. GitOps with ArgoCD

ArgoCD monitors the Helm chart directory:
helm/quakewatch/

Any change (values.yaml, templates/*.yaml, image tag) triggers automatic sync to Kubernetes.

Example:
- Change replicaCount in values.yaml
- Commit & push
- ArgoCD updates Deployment automatically

------------------------------------------------------------
Phase 3 Deliverables
- Published Helm chart in OCI registry
- Functional CI pipeline (pylint + Docker build)
- Functional CD pipeline (DockerHub + ArgoCD sync)
- GitOps flow updating the cluster automatically

------------------------------------------------------------
Files Included

Phase 1:
- Dockerfile
- docker-compose.yml
- app.py
- dashboard.py
- utils.py
- requirements.txt
- static/
- templates/

Phase 2:
- quakewatch-deployment.yaml
- quakewatch-service.yaml
- quakewatch-configmap.yaml
- quakewatch-secret.yaml
- quakewatch-cronjob.yaml
- quakewatch-hpa.yaml

Phase 3:
- Helm Chart:
  - Chart.yaml
  - values.yaml
  - templates/
      - deployment.yaml
      - service.yaml
      - configmap.yaml
      - secret.yaml
      - cronjob.yaml
      - hpa.yaml
- Packaged Chart (quakewatch-0.1.0.tgz)
- GitHub Actions Workflows (CI + CD)
- ArgoCD GitOps configuration

------------------------------------------------------------
Submission Includes:
- Working Docker container
- Kubernetes Deployment
- Service (NodePort)
- Probes (liveness/readiness)
- ConfigMap + Secret
- CronJob + HPA
- Helm chart (source + packaged)
- CI pipeline (pylint + Docker build)
- CD pipeline (DockerHub publish)
- GitOps automation with ArgoCD

------------------------------------------------------------
Author:
adi-yoshay
DevOps Final Course Project – Phases 1, 2 & 3

