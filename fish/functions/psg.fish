function psg
    ps aux | grep $argv | grep -v grep;
end
