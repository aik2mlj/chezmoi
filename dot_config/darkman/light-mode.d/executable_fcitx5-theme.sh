#!/bin/sh

gdbus call \
   --session --dest org.fcitx.Fcitx5 \
   --object-path /controller \
  --method org.fcitx.Fcitx.Controller1.SetConfig \
 fcitx://config/addon/classicui "<{'Theme': <'default'>}>"

