function dcl -d 'bash alias dcl import'
    docker compose logs -f --tail=10 | ccze $argv
end
