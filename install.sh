#!/bin/bash

current_dir=$PWD;
homeconfig="$(ls -F | grep -Eiv \(bin\|install\|readme\|profile\|gitemplates\))";

# Create a symbolic link of the configuration files to the contents of this folder

for file in $homeconfig; do
    source=$file
    destination=$file
    # Custom folder for doom and fish
    if [ $source == "doom/" ]; then
        destination="doom.d/"
    elif [ $source == "fish/" ]; then
        destination="config/fish"
    fi

    if [ ! -f $HOME/.$destination ] ; then
        # ln -s $current_dir/$source $HOME/.$destination
        echo "~/.$destination has been created"
    else
        echo "~/.$destination already exists"
    fi
done

# Make sure the $HOME/.profile file is not a link
# If so, replace it with the system template

if [ -h $HOME/.profile ];then
    rm $HOME/.profile;
    cp /etc/skel/.profile $HOME;
fi

# Make sure the $HOME/.local/bin folder is in the PATH variable

if $(grep "HOME/.local/bin" "$HOME"/.profile >/dev/null 2>&1); then
    echo "$HOME/.local/bin is already in path";
else
    if [ ! -d "$HOME"/.local/bin ]; then
        echo "Creation and adding of ~/.local/bin in the path";
        mkdir -p "$HOME"/.local/bin ;
    else
        echo "The folder ~/.local/bin already exists. It will be added to path";
    fi
    cat >> "$HOME"/.profile <<'EOF'

# set PATH so it includes user's .local/bin folder
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

EOF
fi

if ( ! $(grep "fire_tmux.bash" "$HOME"/.profile >/dev/null 2>&1) ); then
    cat >> $HOME/.profile <<EOF
if [ -f $current_dir/fire_tmux.bash ]; then
    source $current_dir/fire_tmux.bash
fi

EOF
fi


# Load bash alias
source ~/.bash_aliases

# Create a dir template for git hooks
git config --global init.templateDir $current_dir/gitemplates
# Configure delta for beautiful git diff
# git config --global core.pager delta
# git config --global interactive.diffFilter 'delta --color-only --features=interactive'
# git config --global delta.features decorations
# git config --global delta.interactive.keep-plus-minus-markers false
# git config --global delta.syntax-theme gruvbox-white
# git config --global delta.line-numbers true
# git config --global delta.decorations.commit-decoration-style 'blue ol'
# git config --global delta.decorations.commit-style raw
# git config --global delta.decorations.file-style omit
# git config --global delta.decorations.hunk-header-decoration-style 'blue box'
# git config --global delta.decorations.hunk-header-file-style red
# git config --global delta.decorations.hunk-header-line-number-style "#067a00"
# git config --global delta.decorations.hunk-header-style "file line-number syntax"
