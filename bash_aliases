alias tmux="tmux -2"
alias ta="tmux attach"
alias tt="tmux"
alias man="TERM=xterm LC_ALL= w3mman"
alias ls="ls --color=yes --group-directories-first"
alias ee="TERM=xterm-256color emacs -nw"
alias ec="TERM=xterm-256color emacsclient -a \"\" -t"
alias l1="ls -1"
alias ll="ls -lth"
alias la="ls -al"
alias gia='git add .'
alias gib='git branch -vv'
alias gic='git checkout'
alias gif='git fetch'
alias gig='git merge'
alias gil='git log --oneline --graph --all --decorate'
currentver="$(git --version | awk -F' ' '{print $3}')"
requiredver="2.3.0"
if [ "$(printf "$requiredver\n$currentver" | sort -V | head -n1)" == "$currentver" ] && [ "$currentver" != "$requiredver" ];
then
	#echo "git less than 2.3.0 ($currentver)"
        alias gil="git log --graph --all --date=iso --pretty='format:%C(yellow)%h %C(green)%ad %C(bold blue)%an %C(auto)%d%C(reset) %s'"
else
	#echo "git greater than 2.3.0 ($currentver)"
	alias gil="git log --graph --all --date='format:%Y-%m-%d %H:%M:%S' --pretty='format:%C(yellow)%h %C(green)%ad %C(bold blue)%an %C(auto)%d%C(reset) %s'"
fi

alias gill='git pull'
alias gim='git commit'
alias gip='git push'
alias gis='git status'
alias gid='git diff'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias ddo='docker-compose down'
alias dp='docker-compose up | ccze -A'
alias dcl='docker-compose logs -f --tail=10 | ccze -A'
alias dcu='docker-compose up | ccze -A'
alias dcd='docker-compose down'
alias dcb='docker-compose build'
alias dcp='docker-compose pull'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if [ $BASH_VERSION ]; then
source ~/.git-completion.bash
__git_complete gia _git_add
__git_complete gib _git_branch
__git_complete gic _git_checkout
__git_complete gil _git_log
__git_complete gill _git_pull
__git_complete gif _git_fetch
__git_complete gim _git_commit
__git_complete gip _git_push
__git_complete gid _git_diff
fi

psg () { ps aux | grep "$@" | grep -v grep; }
genpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-12};echo;}

if [ $GDMSESSION ]; then
    if [ $GDMSESSION = "gnome" ]; then
	alias lkey="gsettings list-recursively org.gnome.desktop.wm.keybindings";
    fi
fi

export LESS=-iXFR

function parse_yaml() {
    local yaml_file=$1
    local prefix=$2
    local s
    local w
    local fs

    s='[[:space:]]*'
    w='[a-zA-Z0-9_.-]*'
    fs="$(echo @|tr @ '\034')"

    (
        sed -ne '/^--/s|--||g; s|\"|\\\"|g; s/\s*$//g;' \
            -e "/#.*[\"\']/!s| #.*||g; /^#/s|#.*||g;" \
            -e  "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
            -e "s|^\($s\)\($w\)$s[:-]$s\(.*\)$s\$|\1$fs\2$fs\3|p" |

        awk -F"$fs" '{
            indent = length($1)/2;
            if (length($2) == 0) { conj[indent]="+";} else {conj[indent]="";}
            vname[indent] = $2;
            for (i in vname) {if (i > indent) {delete vname[i]}}
                if (length($3) > 0) {
                    vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
                    printf("%s%s%s%s=(\"%s\")\n", "'"$prefix"'",vn, $2, conj[indent-1],$3);
                }
            }' |

        sed -e 's/_=/+=/g' |
        awk 'BEGIN {
                 FS="=";
                 OFS="="
             }
             /(-|\.).*=/ {
                 gsub("-|\\.", "_", $1)
             }
             { print }'

    ) < "$yaml_file"
}

function create_variables() {
    local yaml_file="$1"
    eval "$(parse_yaml "$yaml_file")"
}

function ff() {
    if [ ! -f docker-compose.yml ]; then
	echo "You are not on a docker-compose project"
    else
	odoo_image_name=$(parse_yaml docker-compose.yml | grep services_odoo_image | awk -F'=' '{ print $2 }' |  awk -F'"' '{ print $2 }')
        if [ -z $odoo_image_name ]; then
	   echo "The docker-compose.yml does not contain Odoo image"
    	else
	   filestore_name=$(parse_yaml docker-compose.yml | grep services_odoo_volumes | awk '{for(i=1;i<=NF;i++) {print $i}}' | grep '/var/lib/odoo' | awk -F'=' '{ print $2 }' | awk -F'"' '{ print $2 }' | awk -F':' '{ print $1 }' )
	   if [ -z $filestore_name ]; then
	      echo "The docker-compose.yml does not contain filestore volume"
	   else
	      docker run -it --rm -u root -v $(pwd)/$filestore_name:/var/lib/odoo $odoo_image_name chown -R odoo: /var/lib/odoo
	      if [ $? -eq 0 ]; then
	          echo "Odoo filestore volume UID/GID fixed successfully"
    	      else
		  echo "Odoo filestore volume UID/GID is not fixed!"
    	      fi
	   fi
	fi
    fi
}
