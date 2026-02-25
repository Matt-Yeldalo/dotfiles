# XDG Base Directory variables first (used below)
set -xg XDG_RUNTIME_DIR /run/user/1000
set -xg XDG_CONFIG_HOME $HOME/.config
set -xg XDG_CACHE_HOME $HOME/.cache
set -xg XDG_DATA_HOME $HOME/.local/share
set -xg XDG_STATE_HOME $HOME/.local/state
set -xg XDG_BIN_HOME $HOME/.local/bin
set -xg XDG_SCRIPT_HOME $HOME/.local/script

# Respect XDG specification for various tools
set -xg CONAN_USER_HOME $XDG_CONFIG_HOME
set -xg GOPATH $XDG_DATA_HOME/go
set -xg GOMODCACHE $XDG_CACHE_HOME/go/mod
set -xg RUSTUP_HOME $XDG_DATA_HOME/rustup
set -xg CARGO_HOME $XDG_DATA_HOME/cargo
set -xg SQLITE_HISTORY $XDG_DATA_HOME/sqlite_history
set -xg RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/rg/.ripgreprc
set -xg STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/starship.toml
set -xg HISTFILE $XDG_STATE_HOME/bash/history

# Preserve PATH from parent shell if it exists (optional)
if test -n "$ORIG_PATH"
    set -gx PATH (echo $ORIG_PATH | tr ':' '\n')
else if test -n "$PATH"
    set -gx ORIG_PATH (string join : $PATH)
end

# Use fish_add_path (idempotent, prepends, avoids duplicates)
# Local bins and scripts
fish_add_path $XDG_BIN_HOME
fish_add_path $XDG_SCRIPT_HOME
fish_add_path $XDG_BIN_HOME/color-scripts/

# Common system directories
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin
fish_add_path /usr/bin
fish_add_path /usr/sbin
fish_add_path /bin
fish_add_path /sbin

# Language/toolchain bins
fish_add_path $GOPATH/bin
fish_add_path $CARGO_HOME/bin
fish_add_path /usr/lib/rustup/bin
fish_add_path /usr/lib/go/bin

# Editors/tools
fish_add_path $XDG_DATA_HOME/npm/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin
fish_add_path ~/fzf/bin

# Node/NVM (adjust version if needed; guards are harmless if missing)
fish_add_path ~/.nvm
fish_add_path ~/.nvm/versions/node/v24.10.0/bin

# Ruby (rbenv shims)
fish_add_path ~/.rbenv/shims

# Zig and ZLS (adjust paths to your installs)
fish_add_path ~/zig-linux-x86_64-0.13.0
fish_add_path ~/.zls

# Homebrew (Linuxbrew or macOS; harmless if not present)
fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path ~/.linuxbrew/bin
fish_add_path /opt/homebrew/bin

# Editor and pager
set -xg EDITOR nvim
set -xg VISUAL $EDITOR
set -xg SUDO_EDITOR $EDITOR
set -xg PAGER bat

# FZF configuration
set -xg FZF_DEFAULT_COMMAND "fd --type f --hidden --no-ignore"
set -xg FZF_DEFAULT_OPTS '--height=90% --layout=reverse --info=inline --border rounded --margin=1 --padding=1
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796,fg:#cad3f5,header:#ed8796,info:#b7bdf8,pointer:#f4dbd6,
marker:#b7bdf8,fg+:#cad3f5,prompt:#b7bdf8,hl+:#ed8796,border:#6e738d,label:#cad3f5 --bind=ctrl-u:preview-half-page-up
--bind=ctrl-d:preview-half-page-down --bind="ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)"
--bind=alt-j:down+down+down+down+down --bind="alt-k:up+up+up+up+up"'
set -xg _ZO_FZF_OPTS '--height=90% --layout=reverse --info=inline --border rounded --margin=1 --padding=1
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796,fg:#cad3f5,header:#ed8796,info:#b7bdf8,pointer:#f4dbd6,
marker:#b7bdf8,fg+:#cad3f5,prompt:#b7bdf8,hl+:#ed8796,border:#6e738d,label:#cad3f5 --bind=ctrl-u:preview-half-page-up'
set -xg fzf_preview_dir_cmd eza --long --header --icons --all --color=always --group-directories-first --hyperlink
set -xg fzf_fd_opts --hidden --color=always

# LS colors via vivid (guarded)
if command -q vivid
    set -xg LS_COLORS (vivid generate catppuccin-macchiato)
end

# Starship logging
set -xg STARSHIP_LOG error
