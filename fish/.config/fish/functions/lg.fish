function lg --wraps=lazygit --description 'alias lg=lazygit'
    function is_wsl
        if test -f /mnt/*
            return 0
        else
            return 1
        end
    end
    if type -f lazygit &>/dev/null
        if is_wsl
            lazygit.exe $argv
        else
            lazygit $argv
        end
        lazygit $argv
    else
        missing_package lazygit
    end
end
