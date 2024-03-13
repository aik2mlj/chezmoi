#!/bin/sh

# sed -i 's/set -gx BAT_THEME .*/set -gx BAT_THEME "GitHub"/' $HOME/.config/fish/config.fish
sed -i 's/--theme=.*/--theme="GitHub"/' $HOME/.config/bat/config
