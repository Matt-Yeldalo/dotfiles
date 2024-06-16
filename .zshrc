# ZAP
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "marlonrichert/zsh-autocomplete"
plug "zap-zsh/supercharge"
plug "$HOME/zsh/my-theme.zsh-theme" # Prompt theme
# plug "https://github.com/dikiaap/dotfiles/blob/master/.oh-my-zsh/themes/oxide.zsh-theme"
# plug "zap-zsh/zap-prompt"
# Load and initialise completion system
autoload -Uz compinit
compinit
# MY CONFIG
# ALIAS
alias nvimconfig="cd $HOME/.config/nvim"
alias lvimconfig="cd $HOME/.config/lvim"
alias zshconfig="cd $HOME && nvim .zshrc"
alias gst="git status"
alias cl="clear"
if alias ll>/dev/null; then 
  unalias ll
fi
alias ll="ls -A -h -t -l"
alias lls="ls -h -f"
alias so="source $HOME/.zshrc"
alias wwconfig="nvim /mnt/c/Users/matt/.wezterm.lua"
# FUNCTIONS
# git commit -am "{message}"
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
fpath=($fpath "$HOME/.zfunctions")

