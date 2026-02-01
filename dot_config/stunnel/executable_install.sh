#!/bin/bash
set -e

sudo pacman -S --needed stunnel

SCRIPT_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# link ccrma-imap.conf to /etc/stunnel/stunnel.conf
sudo mkdir -p /etc/stunnel
sudo ln -sf $SCRIPT_DIR/stunnel.conf /etc/stunnel/stunnel.conf

# start stunnel service
sudo systemctl enable --now stunnel.service
