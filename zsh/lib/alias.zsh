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
if command -v eza &>/dev/null; then
  eza_exec="eza --color=always --group-directories-first"
  alias ls="$eza_exec -al --icons"
  alias la="$eza_exec -a --icons"
  alias ll="$eza_exec -l --icons" # Fixed typo here
  alias lt="$eza_exec --icons -aT -L2"
fi

# Find files by name (case insensitive)
# ff() { find . -type f -iname "*$1*" -print; }

# Find directories by name (case insensitive)
# fd() { find . -type d -iname "*$1*" -print; }

# Copy file contents to clipboard
copy() { cat "$1" | pbcopy; }

# Copy output to clipboard (macOS)
alias clip="pbcopy"
alias paste="pbpaste"
alias cd="z"

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
  local model=$(yq '.[].name' ~/.aider/.aider.model.settings.yml | grep -v extra_params | fzf --height 40% --border)
  if [[ -n $model ]]; then
    aider --model "$model" --cache-prompts --no-verify-ssl --env ~/.aider/.env --model-settings-file ~/.aider/.aider.model.settings.yml "$@"
  else
    echo "No model selected"
  fi
}
alias ai="aider-select"

#------------------------------------------------------------------------------
# GIT/ARC ALIASES
#------------------------------------------------------------------------------
# Smart version control function that detects Git or Arc
function is_arc_repo() {
  arc rev-parse --is-inside-work-tree &>/dev/null
  return $?
}

function is_git_repo() {
  git rev-parse --is-inside-work-tree &>/dev/null
  return $?
}

# Smart status command that works with both Git and Arc
function smart_status() {
  if is_arc_repo; then
    arc status "$@"
  elif is_git_repo; then
    git status "$@"
  else
    echo "Not in a Git or Arc repository"
    return 1
  fi
}

function smart_diff() {
  if is_arc_repo; then
    arc diff "$@"
  elif is_git_repo; then
    git diff "$@"
  else
    echo "Not in a Git or Arc repository"
    return 1
  fi
}

function smart_log() {
  if is_arc_repo; then
    arc log --graph --oneline "$@"
  elif is_git_repo; then
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit "$@"
  else
    echo "Not in a Git or Arc repository"
    return 1
  fi
}

function smart_checkout() {
  if is_arc_repo; then
    arc checkout "$@"
  elif is_git_repo; then
    git checkout "$@"
  else
    echo "Not in a Git or Arc repository"
    return 1
  fi
}

function smart_push() {
  if is_arc_repo; then
    arc push "$@"
  elif is_git_repo; then
    git push "$@"
  else
    echo "Not in a Git or Arc repository"
    return 1
  fi
}

function smart_pull() {
  if is_arc_repo; then
    arc pull "$@"
  elif is_git_repo; then
    git pull "$@"
  else
    echo "Not in a Git or Arc repository"
    return 1
  fi
}

# Git/Arc aliases
alias gs="smart_status"
alias gd="smart_diff"
alias gl="smart_log"
alias gco="smart_checkout"
alias gcb="smart_checkout -b"
alias gp="smart_push"
alias gpl="smart_pull"
