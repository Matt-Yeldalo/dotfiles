# NVIM / LVIM
alias nvimconfig="cd $HOME/.config/nvim"
alias lvimconfig="cd $HOME/.config/lvim"
alias gnvimlazy="cd $HOME/.local/share/nvim/lazy"
alias gnvimlog="cd $HOME/.local/state/nvim/"
alias onvim="nvim $HOME/.config/nvim/init.lua"
alias np="cd $HOME/.config/nvim/lua/matt/plugins/"
alias n="nvim"

# FISH (previously ZSH)
alias zshconfig="cd $HOME/dotfiles"
alias dotfiles="cd $HOME/dotfiles/"
alias ofish="nvim $HOME/.config/fish/config.fish"
alias otmux="nvim $HOME/.tmux.conf"
alias obash="nvim $HOME/.bashrc"
alias ozsh="nvim $HOME/dotfiles/.zshrc"
# Note: 'so' needs to be changed to source the fish config
alias so="source $HOME/.config/fish/config.fish"

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
alias addgoogledns="echo 'Adding google dns nameserver to /etc/resolv.conf' && echo 'nameserver 8.8.4.4 \nnameserver 4.4.4.4' | sudo tee -a /etc/resolv.conf"
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
# alias -- -="cd -"

## PROJECTS
alias p="cd $HOME/projects/"
alias p-lang="cd $HOME/projects/lang/"
alias feed="cd $HOME/projects/feed-the-pets/"
alias flashcards="cd $HOME/projects/flashcards/"
alias organise="cd $HOME/projects/organise-my-life/"

# alias l="ls -ltr -A"
# alias lS="l -h -sS"
# alias ll="ls -ltr -A"
