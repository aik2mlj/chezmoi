#!/bin/bash

get_boot_kernel() {
    local get_version=0
    for field in $(file /boot/vmlinuz*); do
        if [[ $get_version -eq 1 ]]; then
            echo $field
            return
        elif [[ $field == version ]]; then
            # the next field contains the version
            get_version=1
        fi
    done
}

rc=1

libs=$(lsof -n +c 0 2> /dev/null | grep 'DEL.*lib' | awk '1 { print $1 ": " $NF }' | sort -u)
if [[ -n $libs ]]; then
    cat <<< $libs
    echo "# LIBS: reboot required"
    rc=0
fi

active_kernel=$(uname -r)
current_kernel=$(get_boot_kernel)
if [[ $active_kernel != $current_kernel ]]; then
    echo "$active_kernel < $current_kernel"
    echo "# KERNEL: reboot required"
    rc=0
fi
exit $rc
