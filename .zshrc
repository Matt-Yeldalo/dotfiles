# ZAP
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "marlonrichert/zsh-autocomplete"
plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
# plug "$HOME/zsh/my-theme.zsh-theme" # Prompt theme
# plug "https://github.com/dikiaap/dotfiles/blob/master/.oh-my-zsh/themes/oxide.zsh-theme"
# Load and initialise completion system
autoload -Uz compinit
compinit
# MY CONFIG
# ALIAS
alias nvimconfig="cd $HOME/.config/nvim"
alias lvimconfig="cd $HOME/.config/lvim"
alias zshconfig="cd $HOME && nvim .zshrc"
alias ozsh="nvim $HOME/zsh/.zshrc"
alias onvim="nvim $HOME/.config/nvim/init.lua"
alias gst="git status"
alias gbr="git branch -vv"
alias lls="ls -h -f"
alias llc="colorls -lA --sd"
if alias ll>/dev/null; then 
  unalias ll
fi
alias ll="ls -ltr -A"
alias so="source $HOME/.zshrc"
# alias wwconfig="nvim /mnt/c/Users/matt/.wezterm.lua"
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
# STARSHIP
eval "$(starship init zsh)"
eval "$($HOME/.rbenv/bin/rbenv init -)"
# assuming that rbenv was installed to `~/.rbenv`
FPATH=$HOME/.rbenv/completions:"$FPATH"
autoload -U compinit
compinit
