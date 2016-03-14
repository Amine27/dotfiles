#!/bin/bash
current_dir="$( cd "$( dirname "$0")" && pwd)" ;
homeconfig="$(ls | egrep -iv \(bin\|install\|readme\|profile\))";
for fichier in $homeconfig; do
    if [ ! -f $HOME/.$fichier ] ; then
	ln -s $current_dir/$fichier .$fichier
	echo ".$fichier a été créé"
    else
	echo ".$fichier exist déjà"
    fi
done

# Le dossier $HOME/.local/bin est utilisé par python-pip
if `grep "HOME/.local/bin" $HOME/.profile >/dev/null 2>&1`; then
    echo "$HOME/.local/bin est déjà dans le path";
else
    echo "Création et ajout de $HOME/.local/bin dans le path";
    mkdir -p $HOME/.local/bin ;
    cat >> $HOME/.profile <<'EOF'
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
EOF
fi

# if [ ! -d bin ]; then
#     mkdir bin
# fi

#wget https://raw.githubusercontent.com/emacsmirror/emacswiki.org/master/sr-speedbar.el -O .emacs.d/sr-speedbar.el

#pip install --user

# apt-get update &&  apt-get upgrade
# apt-get install software-properties-common -y
# add-apt-repository ppa:git-core/ppa -y
# apt-get update
# apt-get install git build-essentials tmux python-pip -y
# apt-get build-dep emacs24

# cd /usr/local/src
# wget http://pdn.local/emacs-24.5.tar.gz
# tar xzf emacs-24.5.tar.gz
# cd emacs-24.5
# .configure && make
