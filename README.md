# Chezmoi Dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

This is my [Garuda Linux](https://garudalinux.org/) desktop setup using [KDE Plasma](https://kde.org/plasma-desktop/), therefore heavily adjusted to my personal preference. It should be able to generalize to other Linux distributions (especially Arch-based ones) with some adjustments. For a general and minimal Linux terminal environment setup, I recommend using my [CLI Toolbox](https://github.com/aik2mlj/cli-toolbox).

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
paru -S --needed ttf-lxgw-bright ttf-lxgw-wenkai noto-fonts-cjk noto-fonts ttf-cascadia-code-nerd amazon-fonts
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

I use [kitty](https://sw.kovidgoyal.net/kitty/) as my main terminal emulator. It's always at the frontier of terminal features like ligatures, cursor animation, image display, etc.

Please take a look at my [CLI Toolbox](https://github.com/aik2mlj/cli-toolbox) where I introduce **must-have** terminal utilities and configurations. Their configs are also included here.

Apart from those, I also found these terminal utils useful on desktop:

- [aerc](https://aerc-mail.org/): A terminal email client. It supports multiple accounts, various backends (including [JMAP](https://jmap.io/)), Vim-style keybindings, HTML rendering (using `chawan` or `w3m`), and has a nice TUI.

- [chawan](https://chawan.net/): A terminal web browser and pager with CSS, inline images, and JavaScript support. I found it more feature-rich than `w3m` or `lynx`.

- [atuin](https://atuin.sh/): A better shell history search and sync tool. It stores your shell history in a SQLite database, supports fuzzy search, and can sync across devices. It encrypts your data before sending to their server, and if you don't trust them you can self-host the server.

## GUI Softwares

My preferred **GUI** softwares:

- [mpv](https://wiki.archlinux.org/title/Mpv): A minimal, versatile and highly customizable media player. My configuration includes several utils (media control & thumbnail generation) and a nice UI skin. Check and run [`~/.config/mpv/packages.install`](dot_config/mpv/executable_packages.install) to install the necessary packages.

- [Zathura](https://wiki.archlinux.org/title/Zathura): A lightweight and customizable PDF viewer with vim-like keybindings. Can even be wrapped to view Office documents like [this](https://wiki.archlinux.org/title/Zathura#Read_Microsoft_Office/LibreOffice_documents_within_zathura).
  - Equally recommended are [Okular](https://okular.kde.org) (KDE Plasma default, works great) and [Sioyek](https://sioyek.info/) (handy smart jump function for viewing research papers).

- [WPS Office](https://wiki.archlinux.org/title/WPS_Office): A solid alternative to Microsoft Office. I find it the most compatible and responsible on Linux.

- [Readest](https://readest.com/): A cross-platform ebook reader with cloud sync across devices. The best open-source eBook reader currently.
  - Also check [Foliate](https://johnfactotum.github.io/foliate/) if you just want a local eBook reader with a nice interface.

- [Syncthing](https://wiki.archlinux.org/title/Syncthing): The best open-source file synchronization tool. It can be used to sync files between your devices, including your phone. There's no subscription or centralized providers, as the data transfer is encrypted in a volunteered p2p network. There is a nice [tray integration](https://wiki.archlinux.org/title/Syncthing#Syncthing_Tray).

- [Kopia](https://kopia.io/): Fast and secure open-source backup software, including both TUI and CLI. It supports both local and various cloud backends. Snapshot scheduling, compression, and encryption all function well. I once wrote [a blog](https://zhuanlan.zhihu.com/p/541234817) in Chinese promoting it.

- [KDE Connect](https://wiki.archlinux.org/title/KDE_Connect): Included in KDE Plasma by default but still worth mentioning. A great tool to integrate your phone with your desktop. It allows you to share clipboards, files, notifications, and control your desktop from your phone.

- [Kdenlive](https://kdenlive.org/): A powerful and user-friendly video editor.

- [Krita](https://krita.org/): A professional open-source painting program, great for digital art and photo editing.

- [Yakuake](https://wiki.archlinux.org/title/Yakuake): A drop-down terminal emulator for KDE Plasma.

- [Obsidian](https://obsidian.md/): A powerful knowledge base that works on top of a local folder of plain text Markdown files. It supports all platforms and has tons of community plugins and themes. I use it for note-taking and knowledge management.
  - Tip: don't want to pay for sync? Use [Syncthing](https://syncthing.net/) to sync your vault across devices.

- [Typst](https://typst.app/): A modern typesetting system that is designed to be as powerful as LaTeX while being much easier to learn and use. I just love its speed and elegant syntax design that surpasses LaTeX so much. Writing math equations feel like a breeze without backslashes. I use it for my academic writing and note-taking.
  - Obsidian user? Check out [this plugin](https://github.com/azyarashi/obsidian-typst-mate) to render Typst math equations in Obsidian.
  - Neovim user? Check out the [extra config](https://www.lazyvim.org/extras/lang/typst) by Lazyvim.

- ~~[Spectacle OCR](Scripts/executable_spectacle-ocr.sh): OCR screenshot utility using `spectacle` and `tesseract`. It allows you to select a region of the screen, take a screenshot, and extract (English + Simplified Chinese) text from it. Mapped to `Meta+Print` in [KDE Plasma shortcuts](dot_config/private_kglobalshortcutsrc).~~ Now with KDE Plasma 6.6, the built-in screenshot tool `spectacle` already supports OCR. Install the necessary packages with:

  ```bash
  paru -S --needed tesseract tesseract-data-eng tesseract-data-chi_sim spectacle  # English + Simplified Chinese (change it to your language)
  ```

## Daemons and Services

- [Libinput-gestures](https://wiki.archlinux.org/title/Libinput#libinput-gestures): Actions gestures on your touchpad using libinput. Bundled with Garuda Linux by default. I map 3-finger swipe up/down to `ctrl-t/w` for quick tab new/close in browsers with [ydotool](https://github.com/ReimuNotMoe/ydotool) (the default `xdotool` mapping is not compatible with Wayland). See [`~/.config/libinput-gestures.conf`](./dot_config/libinput-gestures.conf). Enable it with:

  ```bash
  paru -S --needed libinput-gestures ydotool
  systemctl --user enable --now ydotool.service
  ```

  - Alternative: [Fusuma](https://wiki.archlinux.org/title/Libinput#fusuma) is also configured. Uncomment the line in [`~/.profile`](dot_profile) to enable it. Do not enable both.

- [Firefox Ctrl+W Disable Hook](Scripts/firefox-omni.hook): A pacman post-install hook that patches Firefox to prevent accidental tab closing with Ctrl+W. Handy if you use vim mode in [Typst](https://typst.app/) or [Overleaf](https://www.overleaf.com/). See [this blog post](https://www.math.cmu.edu/~gautam/sj/blog/20220329-firefox-disable-ctrl-w.html) for details. Run [~/Scripts/install-firefox-omni-hook.sh](Scripts/executable_install-firefox-omni-hook.sh) to automatically set it up.

- [Darkman](https://wiki.archlinux.org/title/Dark_mode_switching#Tools): Auto switch light/dark mode based on time and your location, with customizable scripts for many softwares. See my list of configured softwares for [light](dot_config/darkman/light-mode.d)/[dark](dot_config/darkman/dark-mode.d) schemes. Manual toggle keybinding is mapped to `Meta+Shift+D` in [KDE Plasma shortcuts](dot_config/private_kglobalshortcutsrc). Run [`~/.config/darkman/install.sh`](dot_config/darkman/executable_install.sh) to set it up.

- [Caps Lock Enhancement](dot_config/udevmon/): Turn CAPSLOCK into CTRL when key-chording and ESC when pressed alone. Very handy for vim users. I use [keyd](https://github.com/rvaiya/keyd), a great keyboard remapping daemon for this. Run [~/.config/keyd/install.sh](dot_config/keyd/executable_install.sh) to set it up.
  - Alternative: [interception-tools](https://gitlab.com/interception/linux/tools) is another util for altering input events. Run [`~/.config/udevmon/install.sh`](dot_config/udevmon/executable_install.sh) to enable the Caps Lock enhancement with it. Do not enable both.
