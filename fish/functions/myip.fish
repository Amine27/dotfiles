function myip -d 'bash alias myip import'
    curl -w '%{stdout}' ifconfig.me
    # dig +short myip.opendns.com @resolver1.opendns.com $argv
end
