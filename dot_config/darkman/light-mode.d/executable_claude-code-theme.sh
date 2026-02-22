#!/bin/sh

sed -i '/"theme": /d' $HOME/.claude.json
sed -i '/"autoUpdates"/a\  "theme": "light",' $HOME/.claude.json
