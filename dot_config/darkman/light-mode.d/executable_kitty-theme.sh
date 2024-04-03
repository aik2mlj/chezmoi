#!/usr/bin/env bash

kitty +kitten themes Gruvbox\ Light\ Hard

# reload all kitty instances
KITTYPIDS=($(pidof kitty))
for i in "${KITTYPIDS[@]}"; do
	kill -SIGUSR1 $i # see https://sw.kovidgoyal.net/kitty/conf/#kitty-conf
done
