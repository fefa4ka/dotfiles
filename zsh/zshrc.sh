# For vim mappings:
stty -ixon

find ~/dotfiles/tips -type f -print0 | shuf -zn1 | xargs -0 glow

source ~/dotfiles/.env
#source ~/.local/share/python/bin/activate
source ~/.cargo/env
source ~/dotfiles/zsh/alias.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/dotfiles/tmux/tmuxinator.zsh


source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/keybindings.sh
source ~/dotfiles/zsh/plugins/zsh-llm-resolver/zsh-llm-resolver.plugin.zsh

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

source ~/dotfiles/zsh/prompt.sh


# Notes
#dash_comment() { notes add "$*" }
#dash_todo() { notes add "- [ ] $*" }
#alias @="remind"
#alias \#="dash_comment"
#alias \#!="dash_todo"
#alias \#\#="dash_comment _"
#alias \#~="notes ag"

    plugins=(… zsh-completions)
autoload -U compinit && compinit -d ~/.local/share/zsh/.zcompdump

source ~/dotfiles/zsh/toolchain.sh


# Tmux
tm() {
    [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
    if [ $1 ]; then
        tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
    fi
    session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}


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
#source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# color for less and man
export MANPAGER='less -s -M +Gg'
export LESS="--RAW-CONTROL-CHARS"
lesscolors=$HOME/bin/.LESS_TERMCAP
[[ -f $lesscolors ]] && . $lesscolors


HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

eval "$(atuin init zsh)"
export WITH_TMUX=false
PROMPT_LINES=2

# Function to count lines of a command
count_lines() {
  echo "$1" | wc -l
}

# Function to overwrite the previous prompt and command
overwrite_previous() {
  # Count the number of lines in the previous command
  local cmd_lines=$(count_lines "$1")

  # Calculate the total lines to move up (command lines + prompt lines)
  local total_lines=$((cmd_lines + PROMPT_LINES))

  # Move the cursor up and clear each line
  echo ${total_lines}
   for ((i=0; i<total_lines; i++)); do
  print -n "\e[1A\e[K"
   done
}

# Function to be called just before executing a command
preexec_function() {
  overwrite_previous "$1"
  echo "$fg[blue]❯$reset_color $1"
}

# Function to be called just before showing the prompt
precmd_function() {
  # Empty placeholder, used to trigger the prompt refresh if needed
  :
}

# Register hooks for preexec and precmd
autoload -Uz add-zsh-hook
add-zsh-hook preexec preexec_function
add-zsh-hook precmd precmd_function
