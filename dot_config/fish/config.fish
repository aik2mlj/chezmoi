set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.npm-global/bin" $PATH
set -gx PATH /opt/cuda/bin $PATH
set -gx GEM_HOME "$HOME/.local/share/gem/ruby/3.0.0/bin"
set -gx PATH $GEM_HOME $PATH
set -gx MANPAGER "nvim +Man!"

set -gx EDITOR nvim
set -gx VISUAL nvim

# set hostip (cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
# if not in wsl, uncomment this line
set hostip 127.0.0.1
set port 7897
set PROXY_HTTP "http://$hostip:$port"

function unset_proxy
    set -e http_proxy
    set -e HTTP_PROXY
    set -e https_proxy
    set -e HTTPS_PROXY
end
function set_proxy
    set -gx http_proxy "$PROXY_HTTP"
    set -gx HTTP_PROXY "$PROXY_HTTP"
    set -gx https_proxy "$PROXY_HTTP"
    set -gx HTTPS_PROXY "$PROXY_HTTP"
end

# set_proxy

fzf_configure_bindings --directory=\cf
bind \co "yazi-cd; commandline -f repaint"
# bind \co "set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint"
# bind \co ranger-cd

alias ls="eza -b --group-directories-first --icons"
alias la="eza -b -l -a --group-directories-first --icons"
alias ll="eza -b -l --group-directories-first --icons"
alias l.="eza -b -a --group-directories-first --icons | egrep '^\.'" # show only dotfiles

alias rm="/bin/rm -v > ~/.rm.log"

# let's use abbr

abbr svim sudo -E nvim
abbr sys sudo systemctl

abbr vim nvim
abbr df df -h
abbr ra ranger-cd
abbr top btop
abbr nvd watch -n 1 nvidia-smi
abbr cal calcurse

abbr lg lazygit
abbr gs git status
abbr gl "git log --graph --full-history --all --color --pretty=tformat:\"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s%x20%x1b[33m(%an)%x1b[0m\""

abbr fs "fluidsynth --quiet /usr/share/sounds/sf2/GeneralUser\ GS\ v1.471.sf2"

# ====== Copied from garuda's fish config
## Starship prompt
set VIRTUAL_ENV_DISABLE_PROMPT 1
if status is-interactive
    source ("/usr/bin/starship" init fish --print-full-init | psub)
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias wget='wget -c '
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias jctl="journalctl -p 3 -xb"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
# ====== Copying ends

# rclone stuff
alias mount_yuki='rclone mount --vfs-cache-mode writes --vfs-cache-max-size 5G --vfs-cache-max-age 10h --daemon yuki: /mnt/Yuki'
alias mount_yuki_top='rclone mount --vfs-cache-mode writes --vfs-cache-max-size 5G --vfs-cache-max-age 10h --daemon yuki_top: /mnt/Yuki_top'
alias mount_gsd='rclone mount --vfs-cache-mode writes --vfs-cache-max-size 5G --vfs-cache-max-age 10h --daemon gsd: /mnt/GSD'

# color scheme git@github.com:aik2mlj/fish-color-scheme-switcher.git
# scheme set tokyonight
# kanagawa

zoxide init fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /home/aik2/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
alias conda "conda-init; conda"
