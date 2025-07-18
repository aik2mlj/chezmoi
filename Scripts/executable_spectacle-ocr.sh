#!/bin/bash

# Identify the session type
session_type=$XDG_SESSION_TYPE
tesseract_command="tesseract -l eng+chi_sim -c preserve_interword_spaces=1 stdin stdout"

if [ "$session_type" == "wayland" ]; then
    spectacle -b -r -n -o /proc/self/fd/1 | $tesseract_command | wl-copy
else
    spectacle -b -r -n -o /proc/self/fd/1 | $tesseract_command | xclip -in -selection clipboard
fi
