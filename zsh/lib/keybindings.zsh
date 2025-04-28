#==============================================================================
# ZSH KEYBINDINGS
#==============================================================================

#------------------------------------------------------------------------------
# NAVIGATION WIDGETS
#------------------------------------------------------------------------------
# Go up one directory with Ctrl+u
function up_widget() {
    BUFFER="cd .."
    zle accept-line
    zle reset-prompt
}
zle -N up_widget
bindkey "^u" up_widget

# Change directory with fuzzy finder (Ctrl+g)
cd_with_fzf() {
    cd "$(fd -t d $pwd | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}
zle -N cd_with_fzf
bindkey "^g" cd_with_fzf

#------------------------------------------------------------------------------
# FILE OPERATION WIDGETS
#------------------------------------------------------------------------------
# Open file with system default app (Ctrl+o)
open_with_fzf() {
    fd -t f -H -I | fzf -m --preview="([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200" | xargs open
}
zle -N open_with_fzf
bindkey "^o" open_with_fzf

# Open file with $EDITOR (Ctrl+p)
open_editor() {
    fd -t f -H -I | fzf -m --preview="([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200" | xargs $EDITOR
}
zle -N open_editor
bindkey "^p" open_editor

#------------------------------------------------------------------------------
# COMMAND MODIFICATION WIDGETS
#------------------------------------------------------------------------------
# Edit and run previous command (Ctrl+v)
function edit_and_run() {
    BUFFER="fc"
    zle accept-line
}
zle -N edit_and_run
bindkey "^v" edit_and_run

# Prepend sudo to current command (Ctrl+s)
function add_sudo() {
    BUFFER="sudo "$BUFFER
    zle end-of-line
}
zle -N add_sudo
bindkey "^s" add_sudo


#------------------------------------------------------------------------------
# PROCESS WIDGETS
#------------------------------------------------------------------------------
# Process viewer with kill capability with Ctrl+Shift+p
process_viewer() {
  local pid=$(ps aux | fzf --height 80% | awk '{print $2}')
  if [[ -n "$pid" ]]; then
    echo -n "Kill process $pid? (y/n): "
    read answer
    if [[ "$answer" == "y" ]]; then
      kill -9 $pid
      echo "Process $pid killed"
    fi
  fi
  zle reset-prompt
}
zle -N process_viewer
bindkey "^P" process_viewer

#------------------------------------------------------------------------------
# DISABLED/COMMENTED WIDGETS
#------------------------------------------------------------------------------
# Notes widget (currently disabled)
# open_notes() {
#     cd ~/Documents/notes && lt -I "Bear*" | fzf --ansi --query "$LBUFFER" --delimiter='─ ' --preview='filename=$(find . -name {2});([[ -f $filename ]] && (mdv $filename || cat $filename)) || ([[ -d {2} ]] && (exa -aT {2} | less)) || echo {2} 2> /dev/null | head -200' | awk '{split($0, a, " "); print a[2]}' | xargs -n2 -I{2} echo {} _
# }
# zle -N open_notes
# bindkey "^n" open_notes
