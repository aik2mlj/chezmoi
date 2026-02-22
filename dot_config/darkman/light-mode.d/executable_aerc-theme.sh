#!/usr/bin/env bash

sed -i 's/^styleset-name=.*/styleset-name=kanagawa-light/' $HOME/.config/aerc/aerc.conf

aerc ':reload -s kanagawa-light' 2>/dev/null || true
