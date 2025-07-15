#!/bin/bash

# Target install directory
INSTALL_DIR="/usr/local/bin"

# === KIND INSTALLATION ===
if ! command -v kind &>/dev/null; then
  echo "Downloading kind for x86_64..."
  if [ "$(uname -m)" = "x86_64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.29.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind "$INSTALL_DIR/kind"
    echo "✅ kind installed successfully."
  else
    echo "❌ Unsupported architecture: $(uname -m)"
    exit 1
  fi
else
  echo "ℹ️ kind is already installed. Skipping."
fi

# === KUBECTL INSTALLATION ===
if ! command -v kubectl &>/dev/null; then
  VERSION="v1.33.2"
  URL="https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
  echo "Downloading kubectl $VERSION..."
  curl -LO "$URL"
  chmod +x kubectl
  sudo mv kubectl "$INSTALL_DIR/kubectl"
  echo "✅ kubectl installed successfully."
else
  echo "ℹ️ kubectl is already installed. Skipping."
fi

# Show versions
echo ""
echo "🧪 Installed versions:"
kubectl version --client
kind version

echo ""
echo "✅ kind & kubectl installation complete."

