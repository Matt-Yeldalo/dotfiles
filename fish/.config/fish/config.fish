# Run only for interactive shells
if status --is-interactive

    # Source user-specific files if they exist
    for f in ~/.config/fish/user_variables.fish ~/.config/fish/abbreviations.fish ~/.bash_aliases ~/.config/fish/functions/misc.fish
        if test -f $f
            source $f
        end
    end

    # Path and XDG configuration (kept separate for clarity)
    if test -f ~/.config/fish/path_configuration.fish
        source ~/.config/fish/path_configuration.fish
    end

    # Starship: initialize only if available
    if command -q starship
        starship init fish | source
    end

    # Homebrew: guard and prefer dynamic detection
    if command -q brew
        eval (brew shellenv)
    else if test -x /home/linuxbrew/.linuxbrew/bin/brew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    else if test -x ~/.linuxbrew/bin/brew
        eval (~/.linuxbrew/bin/brew shellenv)
    end

    # Cargo env: REMOVE unconditional sourcing (file does not exist).
    # Rely on PATH entries from path_configuration.fish for cargo binaries.
    # If you ever generate a fish env file, re-add guarded sourcing:
    # if test -f ~/.local/share/cargo/env.fish
    #     source ~/.local/share/cargo/env.fish
    # else if test -f ~/.cargo/env.fish
    #     source ~/.cargo/env.fish
    # end

    # Ensure no deprecated bind -k usage remains. Use supported bindings instead.
    # Example: Ctrl-K to kill the current line
    # bind \ck kill-line
end
