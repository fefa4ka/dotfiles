# Vars
HISTFILE=~/notes/.zsh_history
SAVEHIST=1000 
Q1=pi@192.168.1.190
VM=fefa4ka@fefa4ka.sas.yp-c.yandex.net
VC=alexander@192.168.1.153
setopt inc_append_history # To save every command before it is executed 
setopt share_history # setopt inc_append_history

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

export KISYSMOD=/Library/Application\ Support/kicad/modules
export KICAD_SYMBOL_DIR=/Library/Application\ Support/kicad/library


# Path where is libngspice.dylib placed
export DYLD_LIBRARY_PATH=/usr/local/Cellar/libngspice/28/lib/

# Aliases
	alias v="nvim -p"
	alias vi="nvim -p"
	alias vim="nvim -p"
    alias mutt="neomutt"
	alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
    alias console='ssh $VM'
    alias tty='ssh $VC'
    alias cam='ssh $Q1'
    eval $(thefuck --alias)
    alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"

# Config
    alias cfz="vi ~/dotfiles/zsh/zshrc.sh"
    alias cfb="vi ~/dotfiles/bashrc"
    alias cfv="vi ~/.config/nvim/init.vim"
    alias cfa="vi ~/.alacritty.yml"
    alias cft="vi ~/dotfiles/tmux/tmux.conf"
    alias cfm="vi ~/.mutt/muttrc"
    alias cfr="vi ~/.config/ranger/"
    alias cfk="vi ~/.config/skhd/skhdrc"
    alias cfy="vi ~/.config/yabai/yabairc"

	# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
    export LC_ALL=en_US.UTF-8

	export VISUAL=nvim
	export EDITOR=nvim


source ~/dotfiles/zsh/plugins/fixls.zsh
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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
