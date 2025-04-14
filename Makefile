# Makefile at project root

# Load variables from .env if present
ifneq (,$(wildcard .env))
	include .env
	export
endif

# Allow overrides via CLI: make ENV=staging
ENV ?= dev
CLUSTER_NAME ?= miniservice-mesh
K8S_DIR ?= k8s
OVERLAY_DIR = $(K8S_DIR)/overlays/$(ENV)

.PHONY: all build apply diff

## Default help message
all:
	@echo "Available targets:"
	@echo "  make build              # Build the kustomize overlay using .env"
	@echo "  make apply              # Apply the overlay to the cluster"
	@echo "  make diff               # Diff overlay vs live cluster"
	@echo "  You can override ENV and other vars like this:"
	@echo "    make apply ENV=staging"

## Build overlay
build:
	@echo "🔧 Building overlay for '$(ENV)'"
	kustomize build $(OVERLAY_DIR)

## Apply overlay to cluster
apply:
	@echo "🚀 Applying overlay for '$(ENV)'"
	kubectl apply -k $(OVERLAY_DIR)

## Diff overlay vs live cluster
diff:
	@echo "🔍 Diffing overlay for '$(ENV)'"
	kubectl diff -k $(OVERLAY_DIR)