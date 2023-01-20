# Connection
alias console="yc compute instance list --format json | jq '.[] | select((.name == \"vm\") and (.status != \"RUNNING\")) | .id' | xargs -I _ yc compute instance start _ && ssh $VM"
alias tty='ssh $VC'
alias cam='telnet $Q2'

# Utils
alias grep='grep --color=auto'
alias g="lazygit"
if hash nvim; then
    alias v="nvim -p"
    alias vi="nvim -p"
    alias vim="nvim -p"
fi
alias mutt="neomutt"
alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
eval $(thefuck --alias)
if hash bat; then
    alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
fi
if hash exa; then
    exa_exec="exa --color=always --group-directories-first"
    alias ls="$exa_exec -al"
    alias la="$exa_exec -a"
    alias ll="$exa_eexa -l"
    alias lt="$exa_exec --icons -aT"
fi

# Navigation
c() {
    cd $1
    ls
}
alias cd="c"
alias ..="cd .."
alias ...="cd .. && cd .."
alias .3="cd .. && cd .. && cd .."
alias .4="cd .. && cd .. && cd .. && cd .."
alias .5="cd .. && cd .. && cd .. && cd .. && cd .."

# Config
alias cf="vi +\"SLoad config\""
alias cfv="vi +\"SLoad vimrc\""
alias cfz="vi +\"SLoad zshrc\""
alias cfa="vi ~/.config/alacritty/alacritty.yml"
alias cft="vi ~/dotfiles/tmux/tmux.conf"
alias cfm="vi ~/dotfiles/mutt/muttrc"
alias cfr="vi ~/.config/ranger/"
alias cff="vi ~/.config/vifm/vifmrc"
alias cfk="vi ~/.config/skhd/skhdrc"
alias cfy="vi ~/.config/yabai/yabairc"

# SignalQ alias
alias sqt="bash /Volumes/Development/signalq-telnet.sh"
alias squ="bash /Volumes/Development/signalq-uart.sh"
alias qt="/Volumes/Development/signalq2/facility/controller/signalq-telnet.sh"
alias qu="/Volumes/Development/signalq2/facility/controller/signalq-uart.sh"

# nnn
alias nnn='NNN_FIFO="$(mktemp -u)" nnn'

# install python package globally
gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

gpip3() {
    PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}
