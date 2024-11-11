#Deploy a web application in a cloud-based Kubernetes solution, ensuring proper logging and monitoring are in place.

#The web application shall have a simple static page of content.

#Expected Outcome

Your solution should contain the following items.

·    IAC templates (preferably terraform) used to provision the cloud infrastructure.

·    Kubernetes deployment files.

·    Monitoring solution configuration (preferably Prometheus).

·    Dockerfile that was used to containerize the sample web application.

·    Clear documentation on how to deploy your solution.

#########################################################################################################################

# Cloud & DevOps Assessment Solution

## Prerequisites
- Terraform installed
- kubectl installed and configured
- Docker installed

## Steps to Deploy

1. **Provision Infrastructure**
   cd terraform/main.tf
   terraform init
   terraform apply

2. **Build and Push Docker Image**
   
  cd docker/dockerfile
  
  docker build -t swapnilg007/sample-web-app:latest .
  
  docker push swapnilg007/sample-web-app:latest

3. Deploy Web Application

  cd kubernetes
  
  kubectl apply -f deployment.yaml
  
  kubectl apply -f service.yaml
  
4. Deploy Prometheus
   
   kubectl apply -f prometheus.yaml
   Kubectl apply -f prometheus-deployment.yaml




