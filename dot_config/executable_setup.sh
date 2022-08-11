#!/bin/sh

# install paru
sudo pacman -Sy --needed base-devel
sudo pacman -S git
git clone https://aur.archlinux.org/paru.git
cd paru
sudo makepkg -si
cd ..
rm -rf paru

# install rust toolchain
paru -S rustup
rustup toolchain install stable

# install node.js
paru -S npm yarn

# install some utils
paru -S fzf bat exa neovim ranger fd ripgrep lazygit
paru -S xclip xcape

# install fish & fisher
paru -S fish fisher
fisher install jethrokuan/z PatrickF1/fzf.fish
chsh -s /usr/bin/fish

# install fcitx5 & chinese addons
paru -S fcitx5 fcitx-chinese-addons fcitx5-qt kcm-fcitx5

# some beautiful fonts
paru -S ttf-delugia-code ttf-lxgw-wenkai

# copy .config
cp -r config/* ~/.config
rm -rf config/

