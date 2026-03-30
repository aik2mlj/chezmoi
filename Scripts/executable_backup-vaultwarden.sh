#!/bin/bash
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/mnt/ANNEX/backup/vaultwarden"
SSH_HOST="heutz" # from your ssh config
REMOTE_PATH="docker/vaultwarden/vw-data/"

mkdir -p "$BACKUP_DIR"

rsync -az "$SSH_HOST:$REMOTE_PATH" "$BACKUP_DIR/vw-data-$TIMESTAMP"

# Keep only last 30 backups
ls -t "$BACKUP_DIR"/ | tail -n +31 | xargs rm -f
