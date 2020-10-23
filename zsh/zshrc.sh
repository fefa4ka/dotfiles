# Vars
HISTFILE=~/notes/.zsh_history
SAVEHIST=1000 

# Hosts
Q1=pi@192.168.1.190
VM=fefa4ka@fefa4ka.sas.yp-c.yandex.net
VC=alexander@192.168.1.153

setopt inc_append_history # To save every command before it is executed 
setopt share_history # setopt inc_append_history

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Locale
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# KiCad and NGSpice
export KISYSMOD=/Library/Application\ Support/kicad/modules
export KICAD_SYMBOL_DIR=/Library/Application\ Support/kicad/library
# Path where is libngspice.dylib placed
export DYLD_LIBRARY_PATH=/usr/local/Cellar/libngspice/28/lib/


# Aliases
    alias ..="cd .."
    alias ...="cd .. && cd .."
    alias .3="cd .. && cd .. && cd .."
    alias .4="cd .. && cd .. && cd .. && cd .."
    alias .5="cd .. && cd .. && cd .. && cd .. && cd .."
    alias grep='grep --color=auto'
    alias g="lazygit"
    if hash nvim; then
	alias v="nvim -p"
	alias vi="nvim -p"
	alias vim="nvim -p"
    fi
    alias mutt="neomutt"
	alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
    alias console='ssh $VM'
    alias tty='ssh $VC'
    alias cam='ssh $Q1'
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

	# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
    export LC_ALL=en_US.UTF-8

	export VISUAL=nvim
	export EDITOR=nvim


source ~/dotfiles/tmux/tmuxinator.zsh

#Functions
	# Custom cd
	c() {
		cd $1;
		ls;
	}
	alias cd="c"

# For vim mappings: 
	stty -ixon

source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/keybindings.sh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

#source $(brew --prefix autoenv)/activate.sh

source ~/dotfiles/zsh/prompt.sh


# Notes
dash_comment() { notes add "$*" }
dash_todo() { notes add "- [ ] $*" }
alias @="remind"
alias \#="dash_comment"
alias \#!="dash_todo"
alias \#\#="dash_comment _"
alias \#~="notes ag"

plugins=(… zsh-completions)
autoload -U compinit && compinit


# Tmux
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

cd_with_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}

# nnn
alias nnn='NNN_FIFO="$(mktemp -u)" nnn'

# Image frameless preview
# https://github.com/DrabWeb/macfeh
function feh() {
    open -b "drabweb.macfeh" "$@"
}

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
