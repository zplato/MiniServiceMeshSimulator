#!/bin/bash

set -e

CLUSTER_NAME="miniservice-mesh"
DELETE=false

# Help message
show_help() {
  echo "Usage: ./stop-minikube.sh [OPTIONS]"
  echo ""
  echo "Stops or deletes the Minikube cluster."
  echo ""
  echo "Options:"
  echo "  -p, --profile NAME   Set the Minikube cluster profile name (default: miniservice-mesh)"
  echo "  -d, --delete         Delete the cluster entirely instead of just stopping it"
  echo "  -h, --help           Show this help message"
}

# Parse args
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -p|--profile) CLUSTER_NAME="$2"; shift ;;
    -d|--delete) DELETE=true ;;
    -h|--help) show_help; exit 0 ;;
    *) echo "❌ Unknown option: $1"; show_help; exit 1 ;;
  esac
  shift
done


if [ "$DELETE" = true ]; then
  echo "🔥 Deleting Minikube cluster: $CLUSTER_NAME"
  minikube delete --profile "$CLUSTER_NAME"
  echo "✅ Minikube cluster '$CLUSTER_NAME' deleted."
else
  echo "🛑 Stopping Minikube cluster: $CLUSTER_NAME"
  minikube stop --profile "$CLUSTER_NAME"
  echo "✅ Minikube cluster '$CLUSTER_NAME' stopped."
fi
