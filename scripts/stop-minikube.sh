#!/bin/bash

set -e

CLUSTER_NAME="miniservice-mesh"
DELETE=false

show_help() {
  echo "Usage: ./stop-minikube.sh [OPTIONS]"
  echo ""
  echo "Stops or deletes the Minikube cluster named '$CLUSTER_NAME'."
  echo ""
  echo "Options:"
  echo "  -d, --delete     Delete the cluster entirely instead of just stopping it"
  echo "  -h, --help       Show this help message and exit"
  echo ""
  echo "By default, this script stops the running cluster but preserves its state."
  echo "Use --delete to remove the cluster and free up resources completely."
}

# Parse input flags
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -d|--delete) DELETE=true ;;
    -h|--help) show_help; exit 0;;
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
