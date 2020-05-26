time_out () { perl -e 'alarm shift; exec @ARGV' "$@"; }

# Run tmux if exists
if [ -z $WITHOUT_TMUX ];then
    if command -v tmux>/dev/null; then
        tmux -u attach -t _ || tmux -u new -s _ 
    else 
        echo "tmux not installed. Run ./deploy to configure dependencies"
    fi
fi

#(cd ~/dotfiles && time_out 3 git pull && time_out 3 git submodule update --init --recursive)
#(cd ~/dotfiles && git pull && git submodule update --init --recursive)
source ~/dotfiles/zsh/zshrc.sh
