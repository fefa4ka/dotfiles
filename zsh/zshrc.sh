# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=1000 
    VM=fefa4ka@fefa4ka.sas.yp-c.yandex.net
    VC=alexander@192.168.1.154
	setopt inc_append_history # To save every command before it is executed 
	setopt share_history # setopt inc_append_history

export KISYSMOD=/Library/Application\ Support/kicad/modules
export KICAD_SYMBOL_DIR=/Library/Application\ Support/kicad/library

# Path where is libngspice.dylib placed
export DYLD_LIBRARY_PATH=/usr/local/Cellar/libngspice/28/lib/

# Aliases
	alias v="nvim -p"
	alias vi="nvim -p"
	alias vim="nvim -p"
	alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
    alias console='ssh $VM'
    alias tty='ssh $VC'
    eval $(thefuck --alias)
    alias cat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"

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

source $(brew --prefix autoenv)/activate.sh

source ~/dotfiles/zsh/prompt.sh
transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
  tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 
