# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# ZAP
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "marlonrichert/zsh-autocomplete"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
# Load and initialise completion system
autoload -Uz compinit
compinit
# MY CONFIG
# ALIAS
source $HOME/.bash_aliases
alias nvimconfig="cd ~/.config/nvim"
# alias lvimconfig="cd ~/.config/nvim"
alias zshconfig="cd ~ && nvim .zshrc"
alias sshg="ssh -T git@github.com"
alias gst="git status"
alias cl="clear"
if alias ll>/dev/null; then 
  unalias ll
fi
alias ll="ls -a -h -t -l"
alias lls="ls -h -f"
alias so="source $HOME/.zshrc"
# FUNCTIONS
# git commit -am "{message}"
# unalias gca
gca () {
  git commit -am "$1"
}
bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest
# PATH
export PATH="$PATH:$HOME/.local/bin/lvim"
export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$HOME/.cargo/bin/"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
