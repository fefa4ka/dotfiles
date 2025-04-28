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

# Calendar view
alias cal="cal -3"

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

# Find files by name (case insensitive)
ff() { find . -type f -iname "*$1*" -print; }

# Find directories by name (case insensitive)
fd() { find . -type d -iname "*$1*" -print; }

# Copy file contents to clipboard
copy() { cat "$1" | pbcopy; }

# Copy output to clipboard (macOS)
alias clip="pbcopy"
alias paste="pbpaste"

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

# Copy current directory path to clipboard
alias cpwd="pwd | tr -d '\n' | pbcopy && echo 'pwd copied to clipboard'"

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

# Quick Python virtual environment
alias venv="python3 -m venv .venv && source .venv/bin/activate"
alias activate="source .venv/bin/activate"

#------------------------------------------------------------------------------
# DEVELOPMENT TOOLS
#------------------------------------------------------------------------------
alias serve="python3 -m http.server"

#------------------------------------------------------------------------------
# CONNECTION ALIASES
#------------------------------------------------------------------------------
alias console="yc compute instance list --format json | jq '.[] | select((.name == \"vm\") and (.status != \"RUNNING\")) | .id' | xargs -I _ yc compute instance start _ && ssh $VM"

#------------------------------------------------------------------------------
# DEVELOPMENT TOOLS
#------------------------------------------------------------------------------
# Aider with model selection using fzf
aider-select() {
  local model=$(yq '.[].name' ~/.aider/.aider.model.settings.yml | fzf --height 40% --border)
  if [[ -n $model ]]; then
    aider --model "$model" --cache-prompts --no-verify-ssl --env ~/.aider/.env --model-settings-file ~/.aider/.aider.model.settings.yml "$@"
  else
    echo "No model selected"
  fi
}
alias ai="aider-select"
