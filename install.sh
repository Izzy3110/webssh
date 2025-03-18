#!/bin/bash

echo "Defining variables..."
# Domain name
DOMAIN="test.wyl-online.de"

# Email for notifications and recovery
EMAIL="admin@wyl-online.de"

# Directory to store the certificate
CERT_DIR="/etc/letsencrypt/live/$DOMAIN"

######################################################

echo "Update and Upgrade apt package-cache..."
apt-get update && apt-get upgrade -y

######################################################

echo "Installing required apt-packages..."
apt-get install nginx letsencrypt python3 python3-pip python-is-python3 python3-venv -y

######################################################

echo "Installing python-webssh via pip..."
pip3 install --break-system-packages webssh

######################################################

echo "Setting up ufw rules..."
ufw allow "Nginx Full"

######################################################

echo "Setting up nginx systemd - restart at reboot..."
systemctl enable --now nginx

######################################################

echo "Requesting certificate..."
echo "Stopping nginx..."
systemctl stop nginx
certbot certonly --standalone --non-interactive --agree-tos --email "$EMAIL" -d "$DOMAIN"

######################################################

# Verify if the certificate was generated
if [ -f "$CERT_DIR/fullchain.pem" ]; then
    echo ">> Certificate successfully obtained and stored in $CERT_DIR"
else
    echo ">> Failed to obtain the certificate."
    exit 1
fi

systemctl start nginx

######################################################

echo "Setting up auto-renewal..."
cp ./cron.d/certbot /etc/cron.d/certbot

######################################################

echo "Setting up systemd..."
cp ./systemd/system/webssh.service /etc/systemd/system/webssh.service

######################################################

echo "Copying nginx site-config..."
cp ./nginx/sites-available/webssh /etc/nginx/sites-available/webssh

echo "Enabling webssh systemd-service..."
systemctl enable --now webssh
