#!/usr/bin/env bash

sed -i 's/^include.*/include dark.conf/' $HOME/.config/kitty/kitty.conf

# reload all kitty instances
KITTYPIDS=($(pidof kitty))
for i in "${KITTYPIDS[@]}"; do
	kill -SIGUSR1 $i # see https://sw.kovidgoyal.net/kitty/conf/#kitty-conf
done
