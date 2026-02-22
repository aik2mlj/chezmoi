#!/usr/bin/env bash

sed -i 's/^styleset-name=.*/styleset-name=kanagawa/' $HOME/.config/aerc/aerc.conf

aerc ':reload -s kanagawa' 2>/dev/null || true
