# FUNCTIONS
function kitty-reload
    kill -SIGUSR1 (pidof kitty)
end

function catgrep
    printf "Running cat %s | grep %s\n" $argv[1] $argv[2]
    cat $argv[1] | grep $argv[2]
end

function tartar
    tar -xvf $argv[1]
end

function tartargz
    tar -xzvf $argv[1]
end

function oman
    printf "Running man %s | grep %s\n" $argv[1] $argv[2]
    man $argv[1] | grep $argv[2]
end

function toucho
    touch $argv[1] && nvim $argv[1]
end

function mkdira
    mkdir $argv[1] && cd $argv[1]
end

function groutes
    printf "rails routes | grep %s\n" $argv[1]
    rails routes | grep $argv[1]
end

function zout
    set basename (basename "$argv[1]" | cut -d. -f1)
    echo
    zig build-exe $argv[1] && "./$basename" $argv[2]
    echo
end

function coutr
    echo
    gcc -o output $argv[1] && ./output
    echo
end

function cout
    gcc -o output $argv[1]
end

function sus
    printf "sudo systemctl %s %s" $argv[1] $argv[2]
    sudo systemctl $argv[1] $argv[2]
end

function psg
    printf "ps aux | grep %s" $argv[1]
    ps aux | grep $argv[1]
end

# $1 = Branch, $2 = File
function gdf
    printf "git diff HEAD %s -- %s" $argv[1] $argv[2]
    git diff HEAD $argv[1] -- $argv[2]
end

function gca
    git commit -am "$argv[1]"
end

function cat_line
    cat $argv[1] | tr -d "\n"
end

function catr
    tail -n +$argv[1] $argv[3] | head -n (math $argv[2] - $argv[1] + 1)
end

function add_path_tail
    if not contains $argv[1] $PATH
        set -gx PATH $PATH $argv[1]
    end
end

function add_path_head
    if not contains $argv[1] $PATH
        set -gx PATH $argv[1] $PATH
    end
end

# ALIASES - FROM ZSH
function nvimconfig --description 'Navigate to neovim config'
    cd $HOME/.config/nvim
end

function lvimconfig --description 'Navigate to lunarvim config'
    cd $HOME/.config/lvim
end

function gnvimlazy --description 'Navigate to nvim lazy plugin dir'
    cd $HOME/.local/share/nvim/lazy
end

function gnvimlog --description 'Navigate to nvim log directory'
    cd $HOME/.local/state/nvim/
end

function np --description 'Navigate to nvim plugins'
    cd $HOME/.config/nvim/lua/matt/plugins/
end

function zshconfig --description 'Navigate to dotfiles'
    cd $HOME/dotfiles
end

function dotfiles --description 'Navigate to dotfiles'
    cd $HOME/dotfiles/
end

# Edit config functions
function ofish --description 'Edit fish config'
    nvim $HOME/.config/fish/config.fish
end

function onvim --description 'Edit neovim config'
    nvim $HOME/.config/nvim/init.lua
end

function otmux --description 'Edit tmux config'
    nvim $HOME/dotfiles/tmux
end

function obash --description 'Edit bash config'
    nvim $HOME/.bashrc
end

function ozsh --description 'Edit zsh config'
    nvim $HOME/dotfiles/.zshrc
end

function so --description 'Source fish config'
    source $HOME/.config/fish/config.fish
end

# Git functions
function glog --description 'Git log with graph'
    git log --oneline --decorate --graph --parents
end

function gst --description 'Git status'
    git status
end

function gbr --description 'Git branch with verbose info'
    git branch -vv
end

function gf --description 'Git fetch'
    git fetch
end

function gd --description 'Git diff'
    git diff
end

# Shorthand functions
function n --description 'Shorthand for nvim'
    nvim $argv
end

function lg --description 'Launch lazygit'
    lazygit $argv
end

function b --wraps bat --description 'Shorthand for bat'
    batcat $argv
end

function bat --wraps bat --description 'Alias for batcat'
    batcat $argv
end

# Project navigation functions
function p --description 'Navigate to projects directory'
    cd $HOME/projects/
end

function p-lang --description 'Navigate to language projects'
    cd $HOME/projects/lang/
end

function feed --description 'Navigate to feed-the-pets project'
    cd $HOME/projects/feed-the-pets/
end

function flashcards --description 'Navigate to flashcards project'
    cd $HOME/projects/flashcards/
end

function organise --description 'Navigate to organise-my-life project'
    cd $HOME/projects/organise-my-life/
end

# Utility functions
function reloadendwise --description 'Cherry-pick endwise commit'
    git cherry-pick ad5ab41122a0b84f27101f1b5e6e55a681f84b2f
end

function addgoogledns --description 'Add Google DNS to resolv.conf'
    echo 'Adding google dns nameserver to /etc/resolv.conf'
    echo 'nameserver 8.8.4.4 \nnameserver 4.4.4.4' | sudo tee -a /etc/resolv.conf
end

function reloadfonts --description 'Reload font cache'
    fc-cache -f -v
end

function oghostty --description 'Edit ghostty config'
    nvim $HOME/dotfiles/ghostty
end

function wslcode --description 'Open VS Code in WSL'
    /mnt/c/Users/matt/AppData/Local/Programs/'Microsoft VS Code'/bin/code .
end

function okitty --description 'Edit kitty config'
    nvim $HOME/.config/kitty/kitty.conf
end

function buildzig --description 'Build zig project'
    zig build -p $HOME/.local -Doptimize=ReleaseFast -fsys=fontconfig
end

function kitty --description 'Launch kitty terminal'
    $HOME/.local/kitty.app/bin/kitty $argv
end

function og --description 'Launch ghostty'
    $HOME/ghostty/zig-out/bin/ghostty $argv
end

function os --description 'Edit local server script'
    nvim $HOME/projects/localserver.sh
end

function qb --description 'Navigate to quickbench'
    cd $HOME/projects/quickbench/
end

function qn --description 'Navigate to quick-note'
    cd $HOME/projects/quick-note/lua/quick-note/
end

function c --description 'Clear screen'
    clear
end

# ls alternatives
# function l --description 'Detailed list with hidden files'
#     ls -ltr -A $argv
# end
#
# function lS --description 'Sort by size'
#     l -h -sS $argv
# end
#
# function ll --description 'Detailed list with hidden files'
#     ls -ltr -A $argv
# end
