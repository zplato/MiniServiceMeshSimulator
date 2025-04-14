# MiniServiceMeshSimulator

## Overview

Mini Service Mesh Simulator is a lightweight, containerized lab for simulating production microservice environments. It demonstrates:

- Load balancing
- Retries
- Timeouts
- Circuit breaking
- Tracing and metrics
- Network fault simulation

It includes a central router/proxy that orchestrates traffic between services, while also being deployable to Kubernetes with support for Kustomize overlays and environment-specific configuration.

---

## Goal

Simulate multiple microservices communicating via a central router/proxy with:

- ✅ Load balancing
- ✅ Retries
- ✅ Timeouts
- ✅ Circuit breaking
- ✅ Tracing / metrics
- ✅ Environment-specific deployment workflows

---

## Architecture

```
Client --> ServiceMeshRouter --> Microservice A
                                 Microservice B
                                 Microservice C
```

Each microservice can respond, delay, or fail to simulate real-world behavior.

---

## Directory Layout

```
MiniServiceMeshSimulator/
├── mesh_router.py         # Central request router
├── services/
│   ├── service_a.py       # Flask microservice
│   ├── service_b.py
│   └── service_c.py
├── utils/
│   └── circuit_breaker.py # Circuit breaker logic
├── config/
│   └── mesh_config.json   # Routing config & policies
├── test/
│   └── test_requests.py   # Load tests / validation
├── k8s/
│   ├── base/              # Shared manifests
│   └── overlays/          # dev/staging/prod configurations
├── scripts/
│   ├── start-minikube.sh  # Spin up local Minikube cluster
│   └── stop-minikube.sh   # Gracefully stop/delete cluster
├── .env                   # Environment configuration
├── Makefile               # Dev workflow automation
├── requirements.txt
└── README.md
```

---

## Kubernetes Integration

We use **Kustomize** to manage environment-specific configurations.

### Environment Overlays

Each overlay (dev, staging, prod) uses:

- Separate Kubernetes **namespace**
- Patch files to control:
  - Replica count
  - Environment variables
  - Image versions
  - Resource limits

---

## Getting Started

### 1. Prerequisites

Install:

- `minikube`
- `kubectl`
- `kustomize`

Ensure Docker is running and Minikube is installed:
```bash
minikube start --driver=docker
```

---

### 2. Start Kubernetes Environment

```bash
start-minikube --profile miniservice-mesh
```

This script:
- Starts Minikube
- Enables addons (Ingress, Metrics Server, Dashboard)
- Deploys your selected environment

---

### 3. Build and Deploy (Using Make)

```bash
# Default ENV=dev is read from .env file
make build         # Show rendered manifests
make diff          # Diff against live cluster
make apply         # Deploy to cluster
```

To target a specific environment:

```bash
make apply ENV=prod
```

---

### 4. Access Services via Ingress

Add to `/etc/hosts`:
```bash
echo "$(minikube ip) mesh.local" | sudo tee -a /etc/hosts
```

Access:
- `http://mesh.local/nginx`
- `http://mesh.local/flask`

---

### 5. Stop / Clean Up

```bash
stop-minikube                  # Stops the cluster
stop-minikube --delete         # Deletes it entirely
```

---

## Roadmap

- [ ] Add service mesh (e.g., Istio or Linkerd)
- [ ] Include OpenTelemetry tracing
- [ ] Add network fault injection toggles
- [ ] Replace kubeval with kubeconform for CI validation
- [ ] Create GitHub Actions CI pipeline for validating and testing overlays
- [ ] Migrate `prod` overlay to deploy on an AWS EC2 instance (free tier) using K3s, provisioned and managed via Terraform

---

## License

MIT License.

