#!/bin/bash
#current_dir="$( cd "$( dirname "$0")" && pwd)" ;
current_dir=$PWD;
homeconfig="$(ls | egrep -iv \(bin\|install\|readme\|profile\))";
for fichier in $homeconfig; do
    if [ ! -f $HOME/.$fichier ] ; then
	ln -s $current_dir/$fichier $HOME/.$fichier
	echo "~/.$fichier a été créé"
    else
	echo "~/.$fichier exist déjà"
    fi
done

if [ -h $HOME/.profile ];then
    rm $HOME/.profile;
    cp /etc/skel/.profile $HOME;
fi



# Le dossier $HOME/.local/bin est utilisé par python-pip
if `grep "HOME/.local/bin" $HOME/.profile >/dev/null 2>&1`; then
    echo "$HOME/.local/bin est déjà dans le path";
else
    if [ ! -d $HOME/.local/bin ]; then
	echo "Création et ajout de ~/.local/bin dans le path";
	mkdir -p $HOME/.local/bin ;
    else
	echo "Le dossier ~/.local/bin existe déjà. Il va être ajouté au path";
    fi
    cat >> $HOME/.profile <<'EOF'

# set PATH so it includes user's .local/bin folder
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

EOF
fi

if ( ! `grep "fire_tmux.bash" $HOME/.profile >/dev/null 2>&1` ); then
    cat >> $HOME/.profile <<EOF
if [ -f $current_dir/fire_tmux.bash ]; then
    source $current_dir/fire_tmux.bash
fi

EOF
fi

source ~/.bash_aliases
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
