#!/bin/ev bash

set -e

APP_DIR="/opt/react-app"
APP_USER="reactapp"

echo "Updating packages list..."
sudo apt-get update -y

if ! id "APP_USER" &> /dev/null; then
    echo "Creating application user: $APP_USER"
    sudo useradd \
    --system \
    --home "$APP_DIR" \
    --shell /bin/bash \
    "$APP_USER"
fi
echo "Preparing application directory..."
sudo mkdir -p "$APP_DIR"
sudo chown "$APP_DIR:$APP_USER" "$APP_DIR"

echo "Web server setup completed successfully."