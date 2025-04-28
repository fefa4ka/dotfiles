#==============================================================================
# ALIASES AND FUNCTIONS
#==============================================================================

#------------------------------------------------------------------------------
# EDITOR ALIASES
#------------------------------------------------------------------------------
# Use neovim if available
if command -v nvim &>/dev/null; then
  alias v="nvim -p"
  alias vi="nvim -p"
  alias vim="nvim -p"
fi
alias mutt="neomutt"

#------------------------------------------------------------------------------
# UTILITY ALIASES
#------------------------------------------------------------------------------
alias grep='grep --color=auto'
alias g="lazygit"
alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'

# Use bat instead of cat if available
if command -v bat &>/dev/null; then
  alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
fi

# Use exa instead of ls if available
if command -v exa &>/dev/null; then
  exa_exec="exa --color=always --group-directories-first"
  alias ls="$exa_exec -al"
  alias la="$exa_exec -a"
  alias ll="$exa_exec -l" # Fixed typo here
  alias lt="$exa_exec --icons -aT"
fi

#------------------------------------------------------------------------------
# NAVIGATION ALIASES AND FUNCTIONS
#------------------------------------------------------------------------------
# Enhanced cd function that shows directory contents
c() {
  cd $1
  lt -G
}
alias cd="c"

# Directory navigation shortcuts
alias ..="cd .."
alias ...="cd .. && cd .."
alias .3="cd .. && cd .. && cd .."
alias .4="cd .. && cd .. && cd .. && cd .."
alias .5="cd .. && cd .. && cd .. && cd .. && cd .."

#------------------------------------------------------------------------------
# CONFIG FILE SHORTCUTS
#------------------------------------------------------------------------------
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

#------------------------------------------------------------------------------
# PYTHON HELPERS
#------------------------------------------------------------------------------
# Install python packages globally (bypassing virtualenv)
gpip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

gpip3() {
  PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

#------------------------------------------------------------------------------
# CONNECTION ALIASES
#------------------------------------------------------------------------------
alias console="yc compute instance list --format json | jq '.[] | select((.name == \"vm\") and (.status != \"RUNNING\")) | .id' | xargs -I _ yc compute instance start _ && ssh $VM"
