#!/bin/sh

# install darkman, see https://gitlab.com/WhyNotHugo/darkman
sudo pacman -S --needed darkman

# add examples to /usr/share
sudo ln -sf $HOME/.config/darkman/dark-mode.d /usr/share/dark-mode.d
sudo ln -sf $HOME/.config/darkman/light-mode.d /usr/share/light-mode.d

# start systemctl daemon
systemctl --user enable --now darkman.service

# you might want to change the config file at ~/.config/darkman/config.yaml according to https://darkman.whynothugo.nl/
