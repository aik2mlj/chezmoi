#!/bin/sh

pacman -Sy reflector
reflector --country China --sort rate --protocol https,http --save /etc/pacman.d/mirrorlist
pacman -Sy

