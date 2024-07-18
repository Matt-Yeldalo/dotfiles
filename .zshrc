# plug "zsh-users/zsh-autosuggestions"
# plug "zdharma-continuum/fast-syntax-highlighting"
# plug "marlonrichert/zsh-autocomplete"
# plug "zap-zsh/supercharge"
VIM="nvim"
# LIBS
source $HOME/zsh/lib/theme-and-appearance.zsh
source $HOME/zsh/lib/async_prompt.zsh
source $HOME/zsh/lib/git.zsh
# PLUGINS
source $HOME/zsh/themes/robbyrussell.zsh-theme
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# ALIAS
# NVIM / LVIM
alias nvimconfig="cd $HOME/.config/nvim"
alias lvimconfig="cd $HOME/.config/lvim"
alias onvim="nvim $HOME/.config/nvim/lua/matt/init.lua"
alias np="cd $HOME/.config/nvim/lua/matt/plugins/"
alias n="nvim"
# ZSH
alias zshconfig="cd $HOME/zsh"
alias ozsh="nvim $HOME/zsh/.zshrc"
alias so="source $HOME/.zshrc"
# GIT
alias gst="git status"
alias gbr="git branch -vv"
alias gf="git fetch"
alias gd="git diff"
# OTHER
alias lls="ls -h -f"
alias llc="colorls -lA --sd"
alias c="clear"
alias p="cd $HOME/projects/"
alias p-lang="cd $HOME/projects/lang/"
if alias ll>/dev/null; then 
  unalias ll
fi
if alias l>/dev/null; then 
  unalias l
fi
alias l="ls -ltr -A"
alias ll="ls -ltr -A"
# FUNCTIONS
toucho(){
  touch $1 && nvim $1
}
mkdira(){
  mkdir $1 && cd $1
}
coutr(){
  echo
  gcc -o output $1 && ./output
  echo
}
cout(){
  gcc -o output $1
}
gca() { # git commit -am "{message}"
  git commit -am "$1"
}
cat_line() {
  cat $1 | tr -d "\n"
}
catr() {
  tail -n "+$1" $3 | head -n "$(($2 - $1 +1))"
}
add_path_tail() {
  if [[ "$PATH" != "$1" ]]; then
    export PATH=$PATH:$1
  fi
}
add_path_head() {
  if [[ "$PATH" != "$1" ]]; then
    export PATH=$1:$PATH
  fi
}
bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest
# PATH
export NVM_DIR="$HOME/.nvm"
add_path_tail "$HOME/.local/bin/lvim"
add_path_tail "$HOME/.cargo/bin/"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# eval "$($HOME/.rbenv/bin/rbenv init -)"
eval "$(rbenv init - zsh)"
# assuming that rbenv was installed to `~/.rbenv`
FPATH=$HOME/.rbenv/completions:"$FPATH"

autoload -U compinit
compinit

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
