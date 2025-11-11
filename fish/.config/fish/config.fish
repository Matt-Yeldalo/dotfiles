source ~/.config/fish/user_variables.fish
source ~/.config/fish/abbreviations.fish
source ~/.bash_aliases
source ~/.config/fish/functions/misc.fish

starship init fish | source
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
