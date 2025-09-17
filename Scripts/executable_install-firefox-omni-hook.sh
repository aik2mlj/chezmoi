SCRIPT_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

sudo ln -sf $SCRIPT_DIR/patch-firefox-omni.sh /usr/local/bin/patch-firefox-omni.sh
sudo ln -sf $SCRIPT_DIR/firefox-omni.patch /usr/local/bin/firefox-omni.patch
sudo ln -sf $SCRIPT_DIR/firefox-omni.hook /etc/pacman.d/hooks/firefox-omni.hook
