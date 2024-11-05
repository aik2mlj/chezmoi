#!/bin/zsh

patchfile=${1:-$(dirname "$0")/firefox-omni.patch}
echo $patchfile
omni=/usr/lib/firefox/browser/omni.ja

setopt -o err_exit
setopt -o xtrace

[[ -d /tmp/firefox-omni ]] && rm -rf /tmp/firefox-omni
mkdir /tmp/firefox-omni
cd /tmp/firefox-omni
unzip -q $omni || true

patch chrome/browser/content/browser/browser.xhtml $patchfile

zip -0DXqr /tmp/omni.ja *

sudo cp -v $omni $omni.orig
sudo cp -v /tmp/omni.ja $omni

rm -rf /tmp/omni.ja /tmp/firefox-omni
rm -rf /home/aik2/.cache/mozilla/firefox/*/startupCache
