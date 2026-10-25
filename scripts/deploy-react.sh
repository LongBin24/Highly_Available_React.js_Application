#!/usr/bin/env bash

set -e

APP_DIR="/opt/react-app"
APP_USER="reactapp"
SERVICE_NAME="react-app"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 WEB-01|WEB-02"
    exit 2
fi

SERVER_ID="$1"

if [[ "$SERVER_ID" != "WEB-01" && "$SERVER_ID" != "WEB-02" ]]; then
    echo "Error: Server ID must be WEB-01 or WEB-02"
    exit 2
fi

if [ ! -f "$APP_DIR/package.json" ]; then
    echo "Error: $APP_DIR/package.json was not found"
    exit 1
fi

echo "Deploying application to $SERVER_ID..."

sudo chown -R "$APP_USER:$APP_USER" "$APP_DIR"

sudo -u "$APP_USER" bash -c "
    cd '$APP_DIR'
    npm install
    VITE_SERVER_ID='$SERVER_ID' npm run build
"

sudo chown -R "$APP_USER:$APP_USER" "$APP_DIR"

sudo systemctl restart "$SERVICE_NAME"

echo "Deployment completed successfully."
echo "Server ID: $SERVER_ID"
