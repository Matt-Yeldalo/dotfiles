# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
VIM="nvim"
# LIBS
source $HOME/dotfiles/shell/lib/theme-and-appearance.zsh
source $HOME/dotfiles/shell/lib/async_prompt.zsh
source $HOME/dotfiles/shell/lib/git.zsh
# PLUGINS
source $HOME/dotfiles/shell/themes/robbyrussell.zsh-theme
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# ALIAS - source work aliases
source $HOME/.bash_aliases
setopt EXTENDED_GLOB
# Path Map
# typeset -A path_map
# path_file="$HOME/project_paths.txt"
# # Init map
# while IFS='=' read -r key value; do
#   [[ -z "$key" || "$key" =~ ^# ]] && continue
#
#   echo "Inserting: $key = $value"
#
#   $path_map[$key]=$value
# done < "$path_file"
#
# for key in "${(k)path_map}"; do 
#   echo "Key: $key, Value: $path_map[$key]"
# done
# NVIM / LVIM
alias nvimconfig="cd $HOME/.config/nvim"
alias lvimconfig="cd $HOME/.config/lvim"
alias otheme="nvim $HOME/.config/nvim/lua/matt/plugins/theme.lua"
alias gnvimlazy="cd $HOME/.local/share/nvim/lazy"
alias onvim="nvim $HOME/.config/nvim/init.lua"
alias np="cd $HOME/.config/nvim/lua/matt/plugins/"
alias n="nvim"
# ZSH
alias zshconfig="cd $HOME/dotfiles"
alias dotfiles="cd $HOME/dotfiles/"
alias otmux="nvim $HOME/.tmux.conf"
alias ssh='TERM=xterm-256color \ssh'
alias obash="nvim $HOME/.bashrc"
alias ozsh="nvim $HOME/dotfiles/.zshrc"
alias so="source $HOME/.zshrc"
# GIT
alias glog="git log --oneline --decorate --graph --parents"
alias gst="git status"
alias gbr="git branch -vv"
alias lg="lazygit"
alias gf="git fetch"
alias gd="git diff"
# BAT
alias bat="batcat"
alias b="batcat"
# OTHER
alias reloadendwise="git cherry-pick ad5ab41122a0b84f27101f1b5e6e55a681f84b2f"
alias reloadfonts="fc-cache -f -v"
alias oghostty="nvim $HOME/dotfiles/ghostty"
alias wslcode="/mnt/c/Users/matt/AppData/Local/Programs/'Microsoft VS Code'/bin/code ."
alias okitty="nvim $HOME/.config/kitty/kitty.conf"
alias buildzig="zig build -p $HOME/.local -Doptimize=ReleaseFast -fsys=fontconfig"
alias kitty="$HOME/.local/kitty.app/bin/kitty"
alias owez="nvim $HOME/dotfiles/.wezterm.lua"
alias lls="ls -h -f"
alias llc="colorls -lA --sd"
alias og="$HOME/ghostty/zig-out/bin/ghostty"
alias os="nvim $HOME/projects/localserver.sh"
alias qb="cd $HOME/projects/quickbench/"
alias qn="cd $HOME/projects/quick-note/lua/quick-note/"
alias c="clear"
## PROJECTS
alias p="cd $HOME/projects/"
alias p-lang="cd $HOME/projects/lang/"
alias lls="ls -h -f"
alias llc="colorls -lA --sd"
alias so="source $HOME/.zshrc"
alias nc="cd $HOME/.config/nvim/"
alias qn="cd $HOME/quick-notes/"
if alias ll>/dev/null; then 
  unalias ll
fi
if alias l>/dev/null; then 
  unalias l
fi
alias l="ls -ltr -A"
alias ll="ls -ltr -A"
# alias wwconfig="nvim /mnt/c/Users/matt/.wezterm.lua"
# FUNCTIONS
# Override cd to automatically set wezterm tab title
# exists?(){
#  "${path_map[$1]+exists}"
# }
# cd(){
#   # Normal functionality
#   builtin cd "$@" || return
#
#   wezterm cli set-tab-title $(pwd)
# }
# A global find and replace of x to y
find_and_replace(){
  find . -type f -print0| xargs -0 sed -i "s/$1/$2/g"
}
kitty-reload() {
    kill -SIGUSR1 $(pidof kitty)
}
catgrep(){
 printf "Running cat %s | grep %s\n" $1 $2
 cat $1 | grep $2
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
  zig build-exe $1 && "./$basename" $2
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
# $1 = Branch, $2 = File
gdf(){ # git diff HEAD buzz-rails-5.2 -- Gemfile
  printf "git diff HEAD $1 -- $2"
  git diff HEAD $1 -- $2
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
# add_path_tail "$HOME/zig-linux-x86_64-0.14.0-dev.620+eab934814/"
add_path_tail "$HOME/zig-linux-x86_64-0.13.0/"
add_path_tail "$HOME/.zls/zls"
add_path_tail "$HOME/watchman/built/bin/"

add_path_tail "$HOME/.local/bin/ghostty"
add_path_tail "GTK_USE_PORTAL=0"
add_path_tail "GDK_BACKEND=x11"
add_path_tail "DISPLAY=$(hostname).local:0"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# eval "$($HOME/.rbenv/bin/rbenv init -)"
eval "$(rbenv init - zsh)"
# assuming that rbenv was installed to `~/.rbenv`
FPATH=$HOME/.rbenv/completions:"$FPATH"

autoload -U compinit
compinit

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

autoload -Uz compinit && compinit 

