#!/bin/sh

# get Fcitx5's CurrentInputMethod
qdbus "org.fcitx.Fcitx5" "/controller" "org.fcitx.Fcitx.Controller1.CurrentInputMethod"
