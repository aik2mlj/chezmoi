SCRIPT_PATH="$(realpath "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

# install needed packages
# see https://gitlab.com/interception/linux/tools and https://gitlab.com/interception/linux/plugins/caps2esc
sudo pacman -S --needed interception-tools interception-caps2esc

# put configuration file into place
sudo mkdir -p /etc/interception/udevmon.d
sudo ln -sf $SCRIPT_DIR/caps2esc.yaml /etc/interception/udevmon.d

# enable udevmon service
sudo systemctl enable --now udevmon.service
