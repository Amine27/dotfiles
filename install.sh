#!/bin/bash

current_dir=$PWD;
homeconfig="$(ls | egrep -iv \(bin\|install\|readme\|profile\))";

# Crée un lien symbolique des fichiers de configuration vers le
# contenu de ce dossier

for fichier in $homeconfig; do
    if [ ! -f $HOME/.$fichier ] ; then
	ln -s $current_dir/$fichier $HOME/.$fichier
	echo "~/.$fichier a été créé"
    else
	echo "~/.$fichier exist déjà"
    fi
done

# S'assure que le fichier $HOME/.profile n'est pas un lien
# Si oui le remplacer par le template système

if [ -h $HOME/.profile ];then
    rm $HOME/.profile;
    cp /etc/skel/.profile $HOME;
fi



# Le dossier $HOME/.local/bin est utilisé par python-pip
# S'assurer qu'il est dans la variable PATH

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


# Charger les aliases
source ~/.bash_aliases
