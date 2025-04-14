#!/bin/bash

set -e # Exit on error

CLUSTER_NAME="miniservice-mesh"

echo "🔄 Checking if Minikube is already running..."

if ! minikube status --profile "$CLUSTER_NAME" | grep -q "host: Running"; then
  echo "🚀 Starting Minikube cluster: $CLUSTER_NAME"
  minikube start --profile $CLUSTER_NAME --driver=docker --container-runtime=containerd --cpus=4 --memory=8192
else
  echo "✅ Minikube cluster '$CLUSTER_NAME' is already running"
fi

echo "🔌 Enabling addons: ingress, metrics-server, dashboard..."
minikube addons enable ingress --profile "$CLUSTER_NAME"
minikube addons enable metrics-server --profile "$CLUSTER_NAME"
minikube addons enable dashboard --profile "$CLUSTER_NAME"

echo "🌐 Setting current context to: $CLUSTER_NAME"
kubectl config use-context "minikube"

# echo "📂 Applying manifests (optional stub)..."
# kubectl apply -f k8s/  # Uncomment if you have manifests in a k8s/ directory

echo "✅ Done. Minikube is up and running."