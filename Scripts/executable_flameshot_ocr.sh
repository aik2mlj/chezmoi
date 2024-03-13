flameshot gui --raw | tesseract -l eng+chi_sim stdin stdout | xclip -in -selection clipboard
# for wayland
# flameshot gui --raw | tesseract stdin stdout | wl-copy
