# Preserve PATH from parent shell if it exists
if test -n "$ORIG_PATH"
    set -gx PATH (echo $ORIG_PATH | tr ':' '\n')
else if test -n "$PATH"
    # Store original PATH when first starting fish
    set -gx ORIG_PATH (string join : $PATH)
end

# Add standard directories to PATH if not already present
if not contains /bin $PATH
    set -gx PATH $PATH /bin
end

if not contains /usr/bin $PATH
    set -gx PATH $PATH /usr/bin
end

# Add your specific paths here
set -gx PATH /usr/local/bin $PATH
set -gx PATH $HOME/.local/share/nvim/mason/bin $PATH
set -gx PATH $HOME/.local/share/bun/bin $PATH
set -gx PATH /usr/lib/go/bin $PATH
set -gx PATH /usr/lib/rustup/bin $PATH
set -gx PATH $HOME/.local/share/cargo/bin $PATH
set -gx PATH $HOME/.local/share/go/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.rbenv/shims $PATH
set -gx PATH $HOME/.nvm/versions/node/v20.13.1/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/zig-linux-x86_64-0.13.0 $PATH
set -gx PATH $HOME/.zls $PATH
set -gx PATH $HOME/.atuin/bin $PATH
set -gx PATH $HOME/.nvm $PATH
set -gx PATH $HOME/fzf/bin $PATH

# # XDG Directories
set -xg XDG_RUNTIME_DIR $PREFIX/tmp
set -xg XDG_CONFIG_HOME $HOME/.config
# set -xg XDG_CACHE_HOME $HOME/.cache
# set -xg XDG_DATA_HOME $HOME/.local/share
# set -xg XDG_STATE_HOME $HOME/.local/state
# set -xg XDG_BIN_HOME $HOME/.local/bin
# set -xg XDG_SCRIPT_HOME $HOME/.local/script
#
# # Respect XDG Specification
# set -xg CONAN_USER_HOME $XDG_CONFIG_HOME
# set -xg GOPATH $XDG_DATA_HOME/go
# set -xg GOMODCACHE $XDG_CACHE_HOME/go/mod
# set -xg RUSTUP_HOME $XDG_DATA_HOME/rustup
# set -xg CARGO_HOME $XDG_DATA_HOME/cargo
# set -xg SQLITE_HISTORY $XDG_DATA_HOME/sqlite_history
# set -xg RIPGREP_CONFIG_PATH $HOME/.config/rg/.ripgreprc
# set -xg STARSHIP_CONFIG $HOME/.config/starship/starship.toml
# set -xg HISTFILE $XDG_STATE_HOME/bash/history
#
# # Path
fish_add_path $XDG_BIN_HOME
fish_add_path $XDG_BIN_HOME/color-scripts/
fish_add_path $GOPATH/bin
fish_add_path $CARGO_HOME/bin
fish_add_path $XDG_SCRIPT_HOME
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin
fish_add_path /usr/bin
fish_add_path /usr/sbin
fish_add_path /bin
fish_add_path /sbin
fish_add_path /usr/lib/rustup/bin
fish_add_path /usr/lib/go/bin
fish_add_path $XDG_DATA_HOME/npm/bin
fish_add_path $XDG_DATA_HOME/nvim/mason/bin
fish_add_path ~/.nvm
fish_add_path ~/fzf/bin

# Editor
set -xg EDITOR nvim
set -xg VISUAL $EDITOR
set -xg SUDO_EDITOR $EDITOR
set -xg PAGER bat

# FZF
set -xg FZF_DEFAULT_COMMAND fd
set -xg FZF_DEFAULT_OPTS '--height=90% --layout=reverse --info=inline --border rounded --margin=1 --padding=1 --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796,fg:#cad3f5,header:#ed8796,info:#b7bdf8,pointer:#f4dbd6,marker:#b7bdf8,fg+:#cad3f5,prompt:#b7bdf8,hl+:#ed8796,border:#6e738d,label:#cad3f5 --bind=ctrl-u:preview-half-page-up --bind=ctrl-d:preview-half-page-down --bind="ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)" --bind=alt-j:down+down+down+down+down --bind=alt-k:up+up+up+up+up'
set -xg _ZO_FZF_OPTS '--height=90% --layout=reverse --info=inline --border rounded --margin=1 --padding=1 --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796,fg:#cad3f5,header:#ed8796,info:#b7bdf8,pointer:#f4dbd6,marker:#b7bdf8,fg+:#cad3f5,prompt:#b7bdf8,hl+:#ed8796,border:#6e738d,label:#cad3f5 --bind=ctrl-u:preview-half-page-up'
set -xg fzf_preview_dir_cmd eza --long --header --icons --all --color=always --group-directories-first --hyperlink
set -xg fzf_fd_opts --hidden --color=always

# Other
if type -q vivid
    set -xg LS_COLORS (vivid generate catppuccin-macchiato)
end
set -xg STARSHIP_LOG error
