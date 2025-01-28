#!/bin/sh

# sed -i 's/set -gx BAT_THEME .*/set -gx BAT_THEME "Kanagawa"/' $HOME/.config/fish/config.fish
sed -i 's/include.*/include kanagawa-light/' $HOME/.config/zathura/zathurarc

# source the config for all the zathura instances via dbus-send
# https://blog.akaisuisei.org/communicating-with-zathura-via-dbus.html

mapfile -t ZATHURAID < <(dbus-send --session \
    --dest=org.freedesktop.DBus \
    --type=method_call \
    --print-reply \
    /org/freedesktop/DBus \
    org.freedesktop.DBus.ListNames | grep -o 'org.pwmt.zathura.PID-[0-9]*')

zathura_source_config() {
    dbus-send --session \
        --dest=$1 \
        --type=method_call \
        --print-reply \
        /org/pwmt/zathura \
        org.pwmt.zathura.SourceConfig
}

for id in "${ZATHURAID[@]}"; do
    # source two times cuz there is a recolor-keephue bug
    zathura_source_config $id
    zathura_source_config $id
done
