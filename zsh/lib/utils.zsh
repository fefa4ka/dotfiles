# Disable flow control (ctrl+s, ctrl+q)
stty -ixon

# Timeout utility
time_out() { 
  perl -e 'alarm shift; exec @ARGV' "$@"
}

# Image frameless preview
# https://github.com/DrabWeb/macfeh
function feh() {
  open -b "drabweb.macfeh" "$@"
}

# Color for less and man
export MANPAGER='less -s -M +Gg'
export LESS="--RAW-CONTROL-CHARS"
lesscolors=$HOME/bin/.LESS_TERMCAP
[[ -f $lesscolors ]] && . $lesscolors
