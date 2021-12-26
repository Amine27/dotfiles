function alert -d 'bash alias alert import'
    bash -c 'notify-send --urgency=low -i "([ $? = 0 ] && echo terminal || echo error)" "(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"' $argv
end
