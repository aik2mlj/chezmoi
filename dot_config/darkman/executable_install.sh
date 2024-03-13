#!/bin/sh

# add examples to /usr/share
sudo ln -sf $HOME/.config/darkman/dark-mode.d /usr/share/dark-mode.d
sudo ln -sf $HOME/.config/darkman/light-mode.d /usr/share/light-mode.d

# start systemctl daemon
systemctl --user enable --now darkman.service
