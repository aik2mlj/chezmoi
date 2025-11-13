# add some paths
set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.npm-global/bin" $PATH
set -gx PATH /opt/cuda/bin $PATH
set -gx GEM_HOME "$HOME/.local/share/gem/ruby/3.0.0/bin"
set -gx PATH $GEM_HOME $PATH
set -gx PATH "$HOME/Scripts" $PATH

# set the default pager to neovim
set -gx MANPAGER "nvim +Man!"

# set the default editor to neovim
set -gx EDITOR nvim
set -gx VISUAL nvim

# ctrl-f to search for files using fzf.fish
# ctrl-r to search for command history using fzf.fish
fzf_configure_bindings --directory=\cf

# ctrl-o to open yazi and change the current working directory when exiting yazi (see https://yazi-rs.github.io/docs/quick-start#shell-wrapper)
bind \co "yazi-cd; commandline -f repaint"

# use eza instead of ls
alias ls="eza -b --group-directories-first --icons"
alias la="eza -b -l -a --group-directories-first --icons"
alias ll="eza -b -l --group-directories-first --icons"
alias l.="eza -b -a --group-directories-first --icons | egrep '^\.'" # show only dotfiles
# also lt for tree display. see functions/lt.fish
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
alias jctl="journalctl -p 3 -xb"
# safe rm with logging
alias rm="/bin/rm -v > ~/.rm.log"

# let's use fish abbreviation cuz it's more transparent in command history

# for sudo editing files
abbr svim sudo -E nvim
# systemctl commands
abbr sys sudo systemctl
# vim will becomes neovim, comment out the next line if you want to use vim instead of nvim
abbr vim nvim
# human readable df
abbr df df -h
# top will become btop, comment out the next line if you want to use top instead of btop
abbr top btop
# very useful util to monitor GPU resources continuously
abbr nvd watch -n 1 nvidia-smi
# lazygit abbr
abbr lg lazygit
# git abbr
abbr gs git status
abbr gl "git log --graph --full-history --all --color --pretty=tformat:\"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s%x20%x1b[33m(%an)%x1b[0m\""
# command history with timestamps
abbr history history --show-time='%F %T '
# chezmoi
abbr cm chezmoi

if status is-interactive
    # initialize starship prompt
    if type -q starship
        source (starship init fish --print-full-init | psub)
    end
    # initialize zoxide
    if type -q zoxide
        zoxide init fish | source
    end
    # initialize atuin
    if type -q atuin
        atuin init fish --disable-up-arrow | source
    end
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval ~/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# Instead of initializing conda in the config.fish, we use a function to initialize it. This makes the shell loading much faster.
# see functions/conda-init.fish for details
alias conda "conda-init; conda"

# see functions/ for more fish function utils

# ==================== Desktop Additional Settings ====================
#
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

# uncomment the next line to set proxy for terminal
# set_proxy

# deepssek
set -gx DEEPSEEK_API_KEY (cat ~/.deepseek_api_key)

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# rclone stuff
alias mount_yuki='rclone mount --vfs-cache-mode writes --vfs-cache-max-size 5G --vfs-cache-max-age 10h --daemon yuki: /mnt/Yuki'
alias mount_yuki_top='rclone mount --vfs-cache-mode writes --vfs-cache-max-size 5G --vfs-cache-max-age 10h --daemon yuki_top: /mnt/Yuki_top'
alias mount_gsd='rclone mount --vfs-cache-mode writes --vfs-cache-max-size 5G --vfs-cache-max-age 10h --daemon gsd: /mnt/GSD'

# bind \co "set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint"
# bind \co ranger-cd
abbr ra ranger-cd
abbr cal calcurse
abbr fs "fluidsynth --quiet /usr/share/sounds/sf2/GeneralUser\ GS\ v1.471.sf2"

# color scheme git@github.com:aik2mlj/fish-color-scheme-switcher.git
# scheme set tokyonight
# kanagawa
