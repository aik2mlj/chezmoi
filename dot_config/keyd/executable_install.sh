#!/bin/bash
set -e

SCRIPT_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

sudo pacman -S --needed keyd

sudo mkdir -p /etc/keyd/
sudo ln -sf "$SCRIPT_DIR/hailuck.conf" /etc/keyd/

sudo systemctl enable --now keyd
