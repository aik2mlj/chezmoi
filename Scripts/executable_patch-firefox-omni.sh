#!/bin/bash

patchfile=${1:-$(dirname "$0")/firefox-omni.patch}
echo "$patchfile"
omni=/usr/lib/firefox/browser/omni.ja

set -e # Equivalent to 'setopt -o err_exit' in Zsh; exits script on error
set -x # Equivalent to 'setopt -o xtrace' in Zsh; enables command tracing

# Remove old temporary directory if it exists, then create a new one
[ -d /tmp/firefox-omni ] && rm -rf /tmp/firefox-omni
mkdir /tmp/firefox-omni
cd /tmp/firefox-omni

# Unzip the omni.ja file (suppress errors if already unzipped)
unzip -q "$omni" || true

# Apply the patch to the extracted file
patch chrome/browser/content/browser/browser.xhtml "$patchfile"

# Repackage the modified contents into a new omni.ja
zip -0DXqr /tmp/omni.ja *

# Back up the original omni.ja and replace it with the new one
sudo cp -v "$omni" "$omni.orig"
sudo cp -v /tmp/omni.ja "$omni"

# Clean up temporary files and Firefox startup cache
rm -rf /tmp/omni.ja /tmp/firefox-omni
rm -rf /home/aik2/.cache/mozilla/firefox/*/startupCache
