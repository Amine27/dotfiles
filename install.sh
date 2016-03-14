#!/bin/bash

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

current_dir="$( cd "$( dirname "$0")" && pwd)"
homeconfig=$(ls | egrep -iv \(bin\|install\|readme\))
for fichier in $homeconfig; do
    if [ ! -f $HOME/.$fichier ] ; then
	ln -s $current_dir/$fichier $HOME/.$fichier
	echo "$HOME/.$fichier a été créé"
    else
	echo "$HOME/.$fichier exist déjà"
    fi
done
# cd $HOME
# if [ ! -f .emacs.el ]; then
#     ln -s $current_dir/emacs.el .emacs.el
# fi

# if [ ! -f .emacs-custom.el ]; then
#     ln -s $current_dir/emacs-custom.el .emacs-custom.el
# fi

# if [ ! -f .bash_aliases ]; then
#     ln -s $current_dir/bash_aliases .bash_aliases
# fi

# if [ ! -f .git-completion.bash ]; then
#     ln -s $current_dir/git-completion.bash .git-completion.bash
# fi

# cp .profile .profilebk && ln -s $current_dir/profile .profile
# ln -s $current_dir/tmux.conf .tmux.conf


# if [ ! -d .emacs.d ]; then
#     mkdir .emacs.d
# fi

# if [ ! -d bin ]; then
#     mkdir bin
# fi

#wget https://raw.githubusercontent.com/emacsmirror/emacswiki.org/master/sr-speedbar.el -O .emacs.d/sr-speedbar.el

#pip install --user
