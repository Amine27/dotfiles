function ec -d 'bash alias ec import'
    set TERM xterm-256color
    emacsclient -a "" -t $argv
end
