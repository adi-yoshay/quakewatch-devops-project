# QuakeWatch – DevOps Final Course Project
Phase 1: Docker · Phase 2: Kubernetes

QuakeWatch is a Python Flask application that displays real-time and historical earthquake data using the USGS Earthquake API.
This project demonstrates containerization (Phase 1) and Kubernetes deployment (Phase 2).

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

------------------------------------------------------------
Submission Includes:
- Working Docker container
- Kubernetes Deployment
- Service (NodePort)
- Probes (liveness/readiness)
- ConfigMap + Secret
- CronJob
- HPA autoscaling
- All Kubernetes manifests
- Combined README for Phases 1 & 2

------------------------------------------------------------
Author:
adi-yoshay
DevOps Final Course Project – Phase 1 & Phase 2

