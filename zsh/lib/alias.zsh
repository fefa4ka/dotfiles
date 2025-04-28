# Connection
alias console="yc compute instance list --format json | jq '.[] | select((.name == \"vm\") and (.status != \"RUNNING\")) | .id' | xargs -I _ yc compute instance start _ && ssh $VM"
alias tty='ssh $VC'
alias cam='telnet $Q2'

# Utils
alias grep='grep --color=auto'
alias g="lazygit"
if command -v nvim &>/dev/null; then
  alias v="nvim -p"
  alias vi="nvim -p"
  alias vim="nvim -p"
fi
alias mutt="neomutt"
alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
if command -v bat &>/dev/null; then
  alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
fi
if command -v exa &>/dev/null; then
  exa_exec="exa --color=always --group-directories-first"
  alias ls="$exa_exec -al"
  alias la="$exa_exec -a"
  alias ll="$exa_eexa -l"
  alias lt="$exa_exec --icons -aT"
fi

# Navigation
c() {
  cd $1
  lt -G
}
alias cd="c"
alias ..="cd .."
alias ...="cd .. && cd .."
alias .3="cd .. && cd .. && cd .."
alias .4="cd .. && cd .. && cd .. && cd .."
alias .5="cd .. && cd .. && cd .. && cd .. && cd .."

# Config
alias cf="vi +\"SLoad config\""
alias cfv="vi ~/dotfiles/nvim/init.lua"
alias cfz="vi ~/dotfiles/zsh/zshrc.sh"
alias cfa="vi ~/.config/alacritty/alacritty.toml"
alias cft="vi ~/dotfiles/tmux/tmux.conf"
alias cfm="vi ~/dotfiles/mutt/muttrc"
alias cfr="vi ~/.config/ranger/"
alias cff="vi ~/.config/vifm/vifmrc"
alias cfk="vi ~/.config/skhd/skhdrc"
alias cfy="vi ~/.config/yabai/yabairc"

# install python package globally
gpip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

gpip3() {
  PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}
