# up
	function up_widget() {
		BUFFER="cd .."
		zle accept-line
	}
	zle -N up_widget
	bindkey "^K" up_widget

# git
	function git_prepare() {
		if [ -n "$BUFFER" ];
			then
				BUFFER="git add -A; git commit -m \"$BUFFER\" && git push"
		fi

		if [ -z "$BUFFER" ];
			then
				BUFFER="git add -A; git commit -v && git push"
		fi
				
		zle accept-line
	}
	zle -N git_prepare
	bindkey "^g" git_prepare

# home
	function goto_home() { 
		BUFFER="cd ~/"$BUFFER
		zle end-of-line
		zle accept-line
	}
	zle -N goto_home
	bindkey "^h" goto_home

# Edit and rerun
	function edit_and_run() {
		BUFFER="fc"
		zle accept-line
	}
	zle -N edit_and_run
	bindkey "^v" edit_and_run

# LS
	function ctrl_l() {
		BUFFER="ls"
		zle accept-line
	}
	zle -N ctrl_l
	bindkey "^l" ctrl_l

# Enter
	function enter_line() {
		zle accept-line
	}
	zle -N enter_line
	bindkey "^o" enter_line

# Sudo
	function add_sudo() {
		BUFFER="sudo "$BUFFER
		zle end-of-line
	}
	zle -N add_sudo
	bindkey "^s" add_sudo

# Go to
    cd_with_fzf() {
        cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
    }
	zle -N cd_with_fzf 
	bindkey "^f" cd_with_fzf 

# Open file
    open_with_fzf() {
        fd -t f -H -I | fzf -m --preview="([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200" | xargs open 
    }
	zle -N open_with_fzf 
	bindkey "^o" open_with_fzf 
    
# Vim
    open_editor() {
        $EDITOR
    }
	zle -N open_editor
	bindkey "^v" open_editor

# Notes
    open_notes() {
        cd ~/notes && tree --charset=o -f | fzf --query "$LBUFFER" --delimiter='\./' --preview='([[ -f {2} ]] && (mdv {2} || cat {2})) || ([[ -d {2} ]] && (tree -C {2} | less)) || echo {2} 2> /dev/null | head -200' | tr -d '\||`|-' | xargs -0 -I echo notes add_to {} _
    }
    zle -N open_notes
    bindkey "^n" open_notes
