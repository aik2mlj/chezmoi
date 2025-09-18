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

## Font and Input Method

See my font configuration in [`~/.config/fontconfig/fonts.conf`](dot_config/fontconfig/fonts.conf). I also like to set font to `Bookerly` in KDE Plasma system settings. Several fonts to install:

```bash
paru -S --needed ttf-lxgw-bright ttf-lxgw-wenkai noto-fonts-cjk noto-fonts ttf-delugia-code ttf-bookerly
```

I use [fcitx5](https://wiki.archlinux.org/title/Fcitx5) + [rime](https://wiki.archlinux.org/title/Rime) as my input method framework. I pick [rime-ice](https://github.com/iDvel/rime-ice) for Chinese input configuration, with [flypy](https://flypy.cc/) as my double pinyin scheme. Check the configuration in [`~/.local/share/fcitx5/rime`](dot_local/share/private_fcitx5/private_rime).

```bash
# fcitx5 + rime
paru -S --needed fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime
# rime-ice: this includes all supported input schemes
paru -S --needed rime-ice-git
# or better, install just a specific input scheme like flypy
# paru -S --needed rime-ice-double-pinyin-flypy-git
```

Necessary environment variables have been set in [`~/.config/environment.d/fcitx5.conf`](dot_config/environment.d/fcitx5.conf). Additional steps may include [this integration](https://wiki.archlinux.org/title/Fcitx5#KDE_Plasma).

## Terminal Utils

Please take a look at my [remote server configurations](https://github.com/aik2mlj/remote-server-configs) where I introduce many great **terminal** utilities and configurations. They are also included here.

## Desktop Softwares

My preferred **desktop** softwares and utils:

- [mpv](https://wiki.archlinux.org/title/Mpv): A minimal, versatile and highly customizable media player. My configuration includes several utils (media control & thumbnail generation) and a nice UI skin. Check and run [`~/.config/mpv/packages.install`](dot_config/mpv/executable_packages.install) to install the necessary packages.

- [Zathura](https://wiki.archlinux.org/title/Zathura): PDF viewer with vim-like keybindings. It can even be wrapped to view Office documents like [this](https://wiki.archlinux.org/title/Zathura#Read_Microsoft_Office/LibreOffice_documents_within_zathura).

- [WPS Office](https://wiki.archlinux.org/title/WPS_Office): A solid alternative to Microsoft Office. I find it the most compatible and responsible on Linux.

- [Syncthing](https://wiki.archlinux.org/title/Syncthing): The best open-source file synchronization tool. It can be used to sync files between your devices, including your phone. There's no subscription or centralized providers, as the data transfer is encrypted in a volunteered p2p network. There is a nice [tray integration](https://wiki.archlinux.org/title/Syncthing#Syncthing_Tray).

- [Kopia](https://kopia.io/): Fast and secure open-source backup software, including both TUI and CLI. It supports both local and various cloud backends. Snapshot scheduling, compression, and encryption all function well. I once wrote [a blog](https://zhuanlan.zhihu.com/p/541234817) in Chinese promoting it.

- [KDE Connect](https://wiki.archlinux.org/title/KDE_Connect): Included in KDE Plasma by default but still worth mentioning. A great tool to integrate your phone with your desktop. It allows you to share clipboards, files, notifications, and control your desktop from your phone.

- [Yakuake](https://wiki.archlinux.org/title/Yakuake): A drop-down terminal emulator for KDE Plasma.

- [Spectacle OCR](Scripts/executable_spectacle-ocr.sh): OCR screenshot utility using `spectacle` and `tesseract`. It allows you to select a region of the screen, take a screenshot, and extract (English + Simplified Chinese) text from it. Mapped to `Meta+Print` in [KDE Plasma shortcuts](dot_config/private_kglobalshortcutsrc). Install the necessary packages with:

  ```bash
  paru -S --needed tesseract tesseract-data-eng tesseract-data-chi_sim spectacle
  ```

- [Firefox Ctrl+W Disable Hook](Scripts/firefox-omni.hook): A pacman post-install hook that patches Firefox to prevent accidental tab closing with Ctrl+W. Handy if you use vim mode in [Typst](https://typst.app/) or [Overleaf](https://www.overleaf.com/). See [this blog post](https://www.math.cmu.edu/~gautam/sj/blog/20220329-firefox-disable-ctrl-w.html) for details. Run [~/Scripts/install-firefox-omni-hook.sh](Scripts/executable_install-firefox-omni-hook.sh) to automatically set it up.

- [Darkman](https://wiki.archlinux.org/title/Dark_mode_switching#Tools): Auto switch light/dark mode based on time and your location, with customizable scripts for many softwares. See my list of configured softwares for [light](dot_config/darkman/light-mode.d)/[dark](dot_config/darkman/dark-mode.d) schemes. Manual toggle keybinding is mapped to `Meta+Shift+D` in [KDE Plasma shortcuts](dot_config/private_kglobalshortcutsrc). Run [`~/.config/darkman/install.sh`](dot_config/darkman/executable_install.sh) to set it up.

- [Caps Lock Enhancement](dot_config/udevmon/): Turn CAPSLOCK into CTRL when key-chording and ESC when pressed alone using interception-tools. Very handy for vim users. Run [`~/.config/udevmon/install.sh`](dot_config/udevmon/executable_install.sh) to enable this system-wide modification.
