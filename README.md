# 🚀 Recipes App – Cloud-Native DevOps Project

A production-ready, cloud-native web application containerized with Docker and deployed on Kubernetes using DevOps best practices.  
The project demonstrates CI/CD automation with Jenkins, container orchestration with Kubernetes, and secure, scalable application delivery.

---

## 📌 Project Overview

This project showcases a real-world DevOps workflow, starting from containerizing a Python application to deploying it on a Kubernetes cluster with autoscaling, health checks, RBAC, and CI/CD automation.

---

## 🧱 Architecture Highlights

- Dockerized Python web application
- Kubernetes deployment with:
  - Namespaces, Deployments & Services
  - Ingress for traffic routing
  - ConfigMaps & Secrets
  - RBAC (ServiceAccounts, Roles, RoleBindings)
  - Health Probes (Liveness, Readiness, Startup)
  - Horizontal Pod Autoscaler (HPA)
  - Persistent Volumes & Claims
  - Jobs & CronJobs
  - ResourceQuota & LimitRange
- CI/CD pipeline using Jenkins

---

## 🔧 Tech Stack

- Python
- Docker
- Kubernetes
- Jenkins
- YAML

---

## 🔄 CI/CD Pipeline (Jenkins)

1. Checkout source code
2. Build Docker image
3. Push image to Docker Hub
4. Deploy to Kubernetes
5. Verify rollout status

---

## 👤 Author

Eslam Zain  
DevOps Engineer  
