VIM="nvim"
# LIBS
source $HOME/zsh/shell/lib/theme-and-appearance.zsh
source $HOME/zsh/shell/lib/async_prompt.zsh
source $HOME/zsh/shell/lib/git.zsh
# PLUGINS
source $HOME/zsh/shell/themes/robbyrussell.zsh-theme
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# ALIAS
# NVIM / LVIM
alias nvimconfig="cd $HOME/.config/nvim"
alias lvimconfig="cd $HOME/.config/lvim"
alias onvim="nvim $HOME/.config/nvim/init.lua"
alias np="cd $HOME/.config/nvim/lua/matt/plugins/"
alias n="nvim"
# ZSH
alias zshconfig="cd $HOME/zsh"
alias ozsh="nvim $HOME/zsh/.zshrc"
alias obash="nvim $HOME/.bashrc"
alias so="source $HOME/.zshrc"
# GIT
alias gst="git status"
alias gbr="git branch -vv"
alias gf="git fetch"
alias gd="git diff"
alias glog="git log --oneline --decorate --graph --parents"
# BAT
alias bat="batcat"
alias b="batcat"
# OTHER
alias reloadfonts="fc-cache -f -v"
alias wslcode="/mnt/c/Users/matt/AppData/Local/Programs/'Microsoft VS Code'/bin/code ."
alias owez="nvim $HOME/zsh/.wezterm.lua"
alias kitty="$HOME/.local/kitty.app/bin/kitty"
alias okitty="nvim $HOME/.config/kitty/kitty.conf"
alias lls="ls -h -f"
alias llc="colorls -lA --sd"
alias os="nvim $HOME/projects/localserver.sh"
alias qb="cd $HOME/projects/quickbench/"
alias qn="cd $HOME/projects/quick-note/lua/quick-note/"
alias c="clear"
## PROJECTS
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
kitty-reload() {
    kill -SIGUSR1 $(pidof kitty)
}
tartar(){
  tar -xvf $1 
}
tartargz(){
  tar -xzvf $1 
}
oman(){
  printf "Running man %s | grep %s\n" $1 $2
  man $1 | grep $2
}
toucho(){
  touch $1 && nvim $1
}
mkdira(){
  mkdir $1 && cd $1
}
zout(){
  basename=$(basename "$1" | cut -d. -f1)
  echo 
  zig build-exe $1 && "./$basename"
  echo
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
add_path_tail "$HOME/zig-linux-x86_64-0.14.0-dev.620+eab934814/"
add_path_tail "$HOME/.zls/zls"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
eval "$($HOME/.rbenv/bin/rbenv init -)"
eval "$(rbenv init - zsh)"
# assuming that rbenv was installed to `~/.rbenv`
FPATH=$HOME/.rbenv/completions:"$FPATH"

autoload -U compinit
compinit

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

autoload -Uz compinit && compinit 

