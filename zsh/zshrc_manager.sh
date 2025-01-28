time_out () { perl -e 'alarm shift; exec @ARGV' "$@"; }

# Run tmux if exists
if [ ! -z $WITH_TMUX ] && [ -z $TMUX ]; then
    if command -v tmux>/dev/null; then
        tmux -u attach -t _ || tmux -u new -s _ 
    else 
        echo "tmux not installed. Run ./deploy to configure dependencies"
    fi
fi

source ~/dotfiles/zsh/zshrc.sh
