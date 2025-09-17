# Chezmoi Dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

This is my [Garuda Linux](https://garudalinux.org/) desktop setup using [KDE Plasma](https://kde.org/plasma-desktop/), therefore heavily adjusted to my personal preference. It should be able to generalize to other Linux distributions (especially Arch-based ones) with some adjustments. For a general and minimal Linux terminal environment setup, I recommend using my [remote server configurations](https://github.com/aik2mlj/remote-server-configs).

## Installation

I don't recommend using this repository directly, as my dotfiles are tailored to my personal setup and may not work for you. Instead, you should build your own dotfiles from scratch, while perhaps taking this repository as a reference.

But only if you really want to build your dotfiles on top of this, fork this repo first to your own GitHub account, then run:

```bash
# init chezmoi with your forked repo:
chezmoi init git@github.com:yourusername/chezmoi.git

# remove my encrypted files you can't access:
chezmoi cd
find . -name "encrypted_*.age" -delete
git add .
git commit -m "remove encrypted files"
git push
exit

# apply all the dotfiles: (potentially dangerous, review the changes first)
chezmoi apply
```

## Usage

See the [chezmoi documentation](https://www.chezmoi.io/) for more information on how to use it.

## Fonts

See my font configuration in [`~/.config/fontconfig/fonts.conf`](dot_config/fontconfig/fonts.conf). Then I like to set font to `Bookerly` in KDE Plasma system settings. Several fonts to install:

```bash
paru -S --needed ttf-lxgw-bright ttf-lxgw-wenkai noto-fonts-cjk noto-fonts ttf-delugia-code ttf-bookerly
```

## Services to Install

Additional services and configurations that I use, which you may want to install after applying the dotfiles. Details are in the respective shell scripts.

```bash
# a pacman post-install hook to disable ctrl-w for firefox
# see https://www.math.cmu.edu/~gautam/sj/blog/20220329-firefox-disable-ctrl-w.html
~/Scripts/install-firefox-omni-hook.sh

# darkman: auto switch light/dark mode based on time and your location, with customizable scripts
# see https://gitlab.com/WhyNotHugo/darkman
~/.config/darkman/install.sh

# nice mpv config
~/.config/mpv/packages.install

# turn CAPSLOCK into CTRL when key-chording and ESC when pressed alone
~/.config/udevmon/install.sh
```

## Some Goodies to Notice

[`~/Scripts/spectacle-ocr.sh`](Scripts/executable_spectacle-ocr.sh): OCR screenshot utility using `spectacle` and `tesseract`. It allows you to select a region of the screen, take a screenshot, and extract (English + Simplified Chinese) text from it. Mapped to `Meta+Print` in [KDE Plasma shortcuts](dot_config/private_kglobalshortcutsrc). Install the necessary packages with:

```bash
paru -S --needed tesseract tesseract-data-eng tesseract-data-chi_sim spectacle
```
