# KWin 6.8 re-adds GPUs on resume by their real /dev/dri/cardN path; if
# KWIN_DRM_DEVICES uses symlinks the lookup misses and logind refuses the
# second open ("Device already taken") -> black screen. KDE bug 527309.
# Resolve the stable by-path links (dGPU first) to real nodes at login.
_dgpu=$(readlink -f /dev/dri/by-path/pci-0000:01:00.0-card)
_igpu=$(readlink -f /dev/dri/by-path/pci-0000:00:02.0-card)
if [ -e "$_dgpu" ] && [ -e "$_igpu" ]; then
    export KWIN_DRM_DEVICES="$_dgpu:$_igpu"
fi
unset _dgpu _igpu
