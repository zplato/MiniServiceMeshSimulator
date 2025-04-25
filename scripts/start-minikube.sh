#!/bin/bash

set -e # Exit on error

CLUSTER_NAME="miniservice-mesh"

# Help message
show_help() {
  echo "Usage: ./start-minikube.sh [OPTIONS]"
  echo ""
  echo "Starts a Minikube cluster with optional configuration."
  echo ""
  echo "Options:"
  echo "  -p, --profile NAME   Set a custom Minikube cluster profile name"
  echo "  -h, --help           Show this help message"
}

# Parse args
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -p|--profile) CLUSTER_NAME="$2"; shift ;;
    -h|--help) show_help; exit 0 ;;
    *) echo "❌ Unknown option: $1"; show_help; exit 1 ;;
  esac
  shift
done

echo "🔄 Checking if Minikube is already running..."

if ! minikube status --profile "$CLUSTER_NAME" | grep -q "host: Running"; then
  echo "🚀 Starting Minikube cluster: $CLUSTER_NAME"
  minikube start --profile $CLUSTER_NAME --driver=docker --container-runtime=containerd --cpus=4 --memory=8192
else
  echo "✅ Minikube cluster '$CLUSTER_NAME' is already running"
fi

#echo "🔌 Enabling addons: ingress, metrics-server, dashboard..."
#minikube addons enable ingress --profile "$CLUSTER_NAME"
#minikube addons enable metrics-server --profile "$CLUSTER_NAME"
#minikube addons enable dashboard --profile "$CLUSTER_NAME"

echo "🌐 Setting current context to: $CLUSTER_NAME"
kubectl config use-context "$CLUSTER_NAME"

# echo "📂 Applying manifests (optional stub)..."
# kubectl apply -f k8s/  # Uncomment if you have manifests in a k8s/ directory

echo "✅ Done. Minikube is up and running."