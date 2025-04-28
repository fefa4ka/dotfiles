# Display a random tip on startup
if command -v glow >/dev/null; then
  find ~/dotfiles/tips -type f -print0 | shuf -zn1 | xargs -0 glow
fi

# Load environment variables and configurations
source ~/dotfiles/.env
source ~/.cargo/env
export WITH_TMUX=false

# Load core libraries
for lib in ~/dotfiles/zsh/lib/*.zsh; do
  source $lib
done

# Load plugins
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load custom configurations
source ~/dotfiles/zsh/alias.sh
source ~/dotfiles/zsh/keybindings.sh
source ~/dotfiles/zsh/prompt.sh
source ~/dotfiles/zsh/toolchain.sh

# Uncomment to enable these features
#source ~/.local/share/python/bin/activate
#source ~/dotfiles/tmux/tmuxinator.zsh
#source ~/dotfiles/zsh/plugins/zsh-llm-resolver/zsh-llm-resolver.plugin.zsh
#source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# NVM configuration (uncomment if needed)
#export NVM_DIR="$HOME/.nvm"
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Notes functionality (uncomment if needed)
#dash_comment() { notes add "$*" }
#dash_todo() { notes add "- [ ] $*" }
#alias @="remind"
#alias \#="dash_comment"
#alias \#!="dash_todo"
#alias \#\#="dash_comment _"
#alias \#~="notes ag"
