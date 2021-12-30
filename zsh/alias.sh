

# Connection
alias console='ssh $VM'
alias tty='ssh $VC'
alias cam='telnet $Q2'


# Utils
alias grep='grep --color=auto'
alias g="lazygit"
if hash nvim; then
    alias v="nvim -p"
    alias vi="nvim -p"li
    alias vim="nvim -p"
fi
alias mutt="neomutt"
alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
eval $(thefuck --alias)
if hash bat; then
    alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
fi
if hash exa; then
    alias ls="exa -al --color=always --group-directories-first"
    alias la="exa -a --color=always --group-directories-first"
    alias ll="exa -l --color=always --group-directories-first"
    alias lt="exa -aT --color=always --group-directories-first"
fi

# Navigation
c() {
    cd $1;
    ls;
}
alias cd="c"
alias ..="cd .."
alias ...="cd .. && cd .."
alias .3="cd .. && cd .. && cd .."
alias .4="cd .. && cd .. && cd .. && cd .."
alias .5="cd .. && cd .. && cd .. && cd .. && cd .."


# Config
alias cfz="vi ~/dotfiles/zsh/zshrc.sh"
alias cfb="vi ~/dotfiles/bashrc"
alias cfv="vi ~/dotfiles/init.vim"
alias cfa="vi ~/.config/alacritty/alacritty.yml"
alias cft="vi ~/dotfiles/tmux/tmux.conf"
alias cfm="vi ~/.mutt/muttrc"
alias cfr="vi ~/.config/ranger/"
alias cff="vi ~/.config/vifm/vifmrc"
alias cfk="vi ~/.config/skhd/skhdrc"
alias cfy="vi ~/.config/yabai/yabairc"


# SignalQ alias
alias qt="/Volumes/SignalQ/signalq-telnet.sh"
alias qu="/Volumes/SignalQ/signalq-uart.sh"
