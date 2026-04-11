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
end

# Added by `rbenv init` on Wed Mar  4 21:02:54 AEDT 2026
status --is-interactive; and rbenv init - fish | source

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

nvm use v24.10.0 --silent 2>/dev/null
