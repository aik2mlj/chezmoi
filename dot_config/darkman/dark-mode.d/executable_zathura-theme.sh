#!/bin/sh

# sed -i 's/set -gx BAT_THEME .*/set -gx BAT_THEME "Kanagawa"/' $HOME/.config/fish/config.fish
sed -i 's/include.*/include kanagawa-dark/' $HOME/.config/zathura/zathurarc
