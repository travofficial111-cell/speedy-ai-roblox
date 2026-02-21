#!/bin/bash

#===============================================
# Pterodactyl Installation Script for Codespace
# WARNING: May not work due to resource limits
#===============================================

echo "========================================"
echo "  Pterodactyl Installation"
echo "  (For GitHub Codespace)"
echo "========================================"
echo ""
echo "⚠️  WARNING: GitHub Codespaces have limited resources."
echo "    This may not work properly."
echo ""
read -p "Continue anyway? (y/n): " confirm

if [ "$confirm" != "y" ]; then
    echo "Installation cancelled."
    exit 0
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: sudo su"
    exit 1
fi

# Update system
echo "[1/8] Updating system..."
apt update && apt upgrade -y

# Install required packages
echo "[2/8] Installing packages..."
apt install -y curl wget git unzip vim software-properties-common

# Install Docker
echo "[3/8] Installing Docker..."
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com | sh
    systemctl start docker
    systemctl enable docker
fi

# Install Docker Compose
echo "[4/8] Installing Docker Compose..."
curl -L "https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create Pterodactyl directory
echo "[5/8] Setting up Pterodactyl..."
mkdir -p /var/www/pterodactyl
cd /var/www/pterodactyl

# Download panel files
echo "[6/8] Downloading Pterodactyl Panel..."
curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/download/v1.11.3/panel.tar.gz
tar -xzf panel.tar.gz --strip-components=1
rm panel.tar.gz

# Create docker-compose.yml
echo "[7/8] Creating Docker configuration..."
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  panel:
    image: ghcr.io/pterodactyl/panel:latest
    container_name: pterodactyl-panel
    restart: unless-stopped
    ports:
      - "8080:80"
    environment:
      - APP_URL=http://localhost:8080
      - APP_TIMEZONE=America/New_York
      - DB_HOST=db
      - DB_PORT=3306
      - DB_PASSWORD=ChangeMe123!
    volumes:
      - ./storage:/var/www/html/storage
    depends_on:
      - db

  db:
    image: mariadb:latest
    container_name: pterodactyl-db
    restart: unless-stopped
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=ChangeMe123!
      - MYSQL_DATABASE=panel
      - MYSQL_USER=pterodactyl
      - MYSQL_PASSWORD=ChangeMe123!
    volumes:
      - ./mysql:/var/lib/mysql
EOF

# Create environment file
cat > .env << 'EOF'
APP_URL=http://localhost:8080
APP_TIMEZONE=America/New_York
DB_HOST=db
DB_PORT=3306
DB_DATABASE=panel
DB_USERNAME=pterodactyl
DB_PASSWORD=ChangeMe123!
EOF

echo "[8/8] Starting Docker containers..."
docker-compose up -d

echo ""
echo "========================================"
echo "  Installation Complete!"
echo "========================================"
echo ""
echo "🌐 Pterodactyl Panel: http://localhost:8080"
echo ""
echo "⚠️  IMPORTANT NOTES:"
echo "  - This is running in a Codespace (temporary)"
echo "  - For production, install on a real VPS"
echo "  - Default login: admin@pterodactyl.com / admin"
echo ""
echo "To view logs: docker-compose logs -f"
echo "To stop: docker-compose down"
