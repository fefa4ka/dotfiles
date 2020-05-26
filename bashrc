# Tmux
# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -a -F '#S:#I:#P - #{window_name} — #{pane_current_command} - #{pane_current_path} ')
  current_session=$(tmux display-message -p '#S')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_session=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$3}' | cut -c 1)


  if [[ $current_session -eq $target_session && $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
        tmux select-pane -t ${target_window}.${target_pane} 
            tmux select-window -t $target_window 
                tmux switch -t ${target_session} 
  fi
}

# zsh; needs setopt re_match_pcre. You can, of course, adapt it to your own shell easily.
tmuxkillf () {
    local sessions
    sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
    local i
    for i in "${(f@)sessions}"
    do
        [[ $i =~ '([^:]*):.*' ]] && {
            echo "Killing $match[1]"
            tmux kill-session -t "$match[1]"
        }
    done
}
