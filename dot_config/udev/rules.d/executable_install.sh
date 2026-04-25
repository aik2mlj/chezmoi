#!/bin/bash

SCRIPT_PATH="$(realpath "$0")"
RULES_SRC="$(dirname "$SCRIPT_PATH")"
RULES_DST="/etc/udev/rules.d"

for rule in "$RULES_SRC"/*.rules; do
    [[ -f "$rule" ]] || continue
    filename="$(basename "$rule")"

    echo "Linking $filename..."
    sudo ln -sf "$rule" "$RULES_DST/$filename"
done

echo "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger
echo "Done."
