#!/bin/bash

#===============================================
# Docker Test Script for Codespace
# Tests if Docker can run in the environment
#===============================================

echo "========================================"
echo "  Docker Test for Codespace"
echo "========================================"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run as root: sudo su"
    exit 1
fi

echo "[1/4] Checking Docker installation..."
if command -v docker &> /dev/null; then
    echo "✅ Docker is already installed"
    docker --version
else
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    systemctl start docker
    systemctl enable docker
    echo "✅ Docker installed"
    docker --version
fi

echo ""
echo "[2/4] Starting Docker service..."
systemctl start docker 2>/dev/null
systemctl status docker --no-pager || true

echo ""
echo "[3/4] Testing Docker with hello-world..."
if docker run hello-world 2>/dev/null; then
    echo "✅ Docker is working!"
else
    echo "⚠️ Docker may have resource limits in Codespace"
    echo "   Trying alternative test..."
    
    # Try with limited resources
    docker run --memory=256m --cpus=0.5 hello-world 2>/dev/null && echo "✅ Works with limits!" || echo "❌ Docker not working in this environment"
fi

echo ""
echo "[4/4] Checking available resources..."
echo "CPU cores: $(nproc)"
echo "Memory: $(free -h | grep Mem | awk '{print $2}')"
echo "Disk space: $(df -h / | tail -1 | awk '{print $4}')"

echo ""
echo "========================================"
echo "  Test Complete"
echo "========================================"
echo ""
echo "If Docker works, you can proceed with Pterodactyl."
echo "If not, you need a real VPS for Pterodactyl."
