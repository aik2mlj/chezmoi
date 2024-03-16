#!/bin/bash

# Identify the session type
session_type=$XDG_SESSION_TYPE
tesseract_command="tesseract -l eng+chi_sim -c preserve_interword_spaces=1 stdin stdout"

if [ "$session_type" == "wayland" ]; then
    flameshot gui --raw | $tesseract_command | wl-copy
else
    flameshot gui --raw | $tesseract_command | xclip -in -selection clipboard
fi
