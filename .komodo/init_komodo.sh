#!/usr/bin/env bash
set -e

# Check if 1Password CLI is installed
if ! command -v op &>/dev/null; then
    echo "Error: 1Password CLI is not installed. Please install it first."
    echo "Visit https://1password.com/downloads/command-line/ for instructions."
    exit 1
fi

# Check if 1Password is signed in
if ! op user list &>/dev/null; then
    echo "Error: You are not signed in to 1Password CLI."
    echo "Please run 'op signin' before running this script."
    exit 1
fi

# Check for Python 3
if ! command -v python3 &>/dev/null; then
    echo "Error: Python 3 is required but not installed."
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
    echo "Docker could not be found. Please install Docker and try again."
    exit 1
fi

echo "Docker is installed. Proceeding with resource creation..."

# Create Docker resources
docker network create --driver=bridge --attachable internal
docker network create --driver=bridge --attachable --subnet=10.99.0.0/24 public
docker network create --driver=bridge --attachable kop
docker network create --driver=bridge --internal --attachable crowdsec
docker network create --driver bridge --subnet 172.28.0.0/16 traefik
docker network create --driver bridge --attachable gitea
docker network create --driver bridge --attachable media
docker network create --driver bridge --attachable monitor
docker network create --driver bridge --attachable nextcloud
docker volume create repo-cache

echo "Installing Komodo Periphery..."
curl -sSL https://raw.githubusercontent.com/moghtech/komodo/main/scripts/setup-periphery.py | python3 - --user

echo "Generating configuration from template..."
if [ ! -f periphery/periphery.config.toml.tpl ]; then
    echo "Error: Template file periphery.config.toml.tpl not found."
    exit 1
fi

op inject -i periphery/periphery.config.toml.tpl -o periphery/periphery.config.toml
if [ $? -eq 0 ]; then
    echo "Komodo Periphery has been successfully installed and configured."
    echo "Configuration file: $(realpath periphery/periphery.config.toml)"
else
    echo "Error: Failed to generate configuration file."
    exit 1
fi

mv "$HOME"/.config/komodo/periphery.config.toml periphery.config.toml.bak
mv periphery.config.toml "$HOME"/.config/komodo

if [ ! -f core/.env.tpl ]; then
    echo "Error: Template file .env.tpl not found."
    exit 1
fi

op inject -i core/.env.tpl -o core/.env
if [ $? -eq 0 ]; then
    echo "Configuration file: $(realpath core/.env)"
else
    echo "Error: Failed to generate configuration file."
    exit 1
fi

if [ ! -f core/core.config.toml.tpl ]; then
    echo "Error: Template file .env.tpl not found."
    exit 1
fi

op inject -i core/core.config.toml.tpl -o core/core.config.toml
if [ $? -eq 0 ]; then
    echo "Configuration file: $(realpath core/core.config.toml)"
else
    echo "Error: Failed to generate configuration file."
    exit 1
fi

if [ ! -f /opt/docker/homepage/custom/.env.tpl ]; then
    echo "Error: Template file .env.tpl not found."
    exit 1
fi

op inject -i /opt/docker/homepage/custom/.env.tpl -o /opt/docker/homepage/custom/.env
if [ $? -eq 0 ]; then
    echo "Configuration file: $(realpath /opt/docker/homepage/custom/.env.tpl)"
else
    echo "Error: Failed to generate configuration file."
    exit 1
fi

systemctl --user restart periphery
systemctl --user status periphery
