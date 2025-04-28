# Load the main zsh configuration
source ~/dotfiles/zsh/zshrc.sh

# Run tmux if requested and not already in a tmux session
if [ ! -z $WITH_TMUX ] && [ -z $TMUX ]; then
    if command -v tmux>/dev/null; then
        tmux -u attach -t _ || tmux -u new -s _ 
    else 
        echo "tmux not installed. Run ./deploy to configure dependencies"
    fi
fi
