# Load and initialize the completion system
plugins=(zsh-completions)
autoload -U compinit && compinit -d ~/.local/share/zsh/.zcompdump

# Source Oh-My-Zsh completion
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
