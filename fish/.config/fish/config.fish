source ~/.config/fish/user_variables.fish
source ~/.config/fish/abbreviations.fish
source ~/.bash_aliases
source ~/.config/fish/functions/misc.fish

set fish_cursor_default block
set fish_vi_force_cursor 1

starship init fish | source
