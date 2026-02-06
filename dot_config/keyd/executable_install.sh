#!/bin/bash
set -e

SCRIPT_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

sudo pacman -S --needed keyd

sudo mkdir -p /etc/keyd/
# ln -sf every conf file underin the keyd directory to /etc/keyd/
for file in "$SCRIPT_DIR"/*.conf; do
    sudo ln -sf "$file" /etc/keyd/
done

sudo systemctl enable --now keyd
