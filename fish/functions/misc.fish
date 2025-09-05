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
