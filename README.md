## `dotfiles` installation
This repository contains the configuration files for the `emacs` editor, `fish` shell and the `tmux` multiplexer.
These files can be installed for the current user with the `install.sh` script contained in the repository:
``` sh
cd && git clone https://github.com/Amine27/dotfiles .dotfiles && cd .dotfiles && . install.sh && cd
```

## Setup tools
``` sh
# Emacs new version in Ubuntu
sudo add-apt-repository ppa:kelleyk/emacs
# Node.js v16.x LTS
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
# Install required packages
sudo apt install fish tmux emacs27-nox nodejs
# Install tmuxinator to manage tmux sessions
sudo gem install tmuxinator
# Download and install Git delta for nice git diff
# apt install git-delta or https://github.com/dandavison/delta/releases
# Install and configure Doom Emacs with local configurations
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom sync
# Install Fisher package manager (execture within fish shell)
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
# Install z for easy file navigation and lucid prompt theme
fisher install jethrokuan/z mattgreen/lucid.fish
```

## Fish shell
- `fish` shell is only enabled in `tmux` for now.

## Emacs
- The prefix `C` represents the `Ctrl` key on the keyboard.
- The prefix `M` represents the `Alt` key on the keyboard.

<details>
  <summary>Shortcuts</summary>

| Shortcut              | Description                                 |
| --------------------- | ------------------------------------------- |
| C-x C-f               | find file                                   |
| C-x C-s               | save file                                   |
| C-x C-f filename      | create new file with filename               |
| C-x C-f C             | copy file                                   |
| C-x C-f R             | rename file                                 |
| C-x C-f D             | delete file                                 |
| C-x 3                 | split window left/right                     |
| C-x 2                 | split window top/bottom                     |
| C-x 1                 | unsplit all (remover other window)          |
| C-x 0                 | remove current window                       |
| C-x o                 | move cursor to next window                  |
| C-M-v                 | scroll the text of the next window          |
| M-Del                 | kill the word immediately before the cursor |
| M-d                   | kill the next word after the cursor         |
| C-k                   | kill to the end of line                     |
| C-y                   | yank (past) the most recent kill            |
| M-y                   | yank (past) previous kills                  |
| C-x h                 | select all                                  |
| C-Space               | mark region                                 |
| C-/, C-x u, C-_       | undo                                        |
| C-w                   | cut marked text                             |
| M-w                   | copy marked text                            |
| C-x /                 | comment / uncomment current line            |
| C-x c-u               | to upper case marked region                 |
| C-x c-l               | to lower case marked region                 |
| C-o                   | insert blanc line                           |
| C-x c-b               | list buffers                                |
| C-x b                 | switch buffer                               |
| C-x s                 | save some buffers                           |
| C-h ?                 | help commands                               |
| C-h r                 | read help                                   |
| C-h t                 | read tutorial                               |
| C-x C-c               | quit Emacs                                  |
| C-g                   | abort command                               |
| M-x recover-this-file | recover current file from #file             |
| C-s                   | forward search                              |
| C-r                   | reverse search                              |
| C-f                   | forward one caracter                        |
| C-b                   | backward one caracter                       |
| C-p                   | previous one line                           |
| C-n                   | next one line                               |
| M-f                   | forward one word                            |
| M-b                   | backward one word                           |
| C-a                   | beginning of line                           |
| C-e                   | end of line                                 |
| M-a                   | beginning of sentence                       |
| M-e                   | end of sentence                             |
| C-v                   | go forward one screen                       |
| M-v                   | go backward one screen                      |
| M-<                   | start of document                           |
| M->                   | end of document                             |

</details>

## Tmux
- The default `C-b` prefix has been changed to `C-q` which is more accessible.

<details>
  <summary>Shortcuts</summary>

| Shortcut    | Tmux command           | Descriptive                                                            |
|-------------|------------------------|------------------------------------------------------------------------|
| C-q ?       | list-keys              | affiche l'aide                                                         |
| C-q c       | new-window             | nouvelle fenêtre                                                       |
| C-q d       | detach-client          | se détache de tmux mais le laisse rouler                               |
| C-q /       | split-window -v        | coupe la fenêtre ou le pane courant en 2 verticalement                 |
| C-q i       | split-window -h        | coupe la fenêtre ou le pane courant en 2 horizontalement               |
| C-q Tab     | copy-mode              | entre dans un mode qui permet de remonter dans la sortie du terminal   |
| C-q y       | paste-buffer           | colle ce qui a été copié pendant le copy-mode                          |
| F1          | previous-window        | afficher le panneau précédent                                          |
| F2          | next-window            | afficher le panneau suivant                                            |
| C-q l       | last-window            | go to previous window                                                  |
| M-Up        | select-pane -U         | déplace le curseur vers le panneau du haut                             |
| M-Down      | select-pane -D         | déplace le curseur vers le panneau du bas                              |
| M-Left      | select-pane -L         | déplace le curseur vers le panneau de gauche                           |
| M-Right     | select-pane -R         | déplace le curseur vers le panneau de droite                           |
| C-q Up      | select-pane -U         | idem mais en utilisant le préfix et sans le META                       |
| C-q Down    | select-pane -D         |                                                                        |
| C-q Left    | select-pane -L         |                                                                        |
| C-q Right   | select-pane -R         |                                                                        |
| C-q b       | choose-window          | liste les fenêtres actives et permet de se déplacer dans l'une d'elles |
| C-q o       | select-pane -t :.+     | déplace le curseur dans le panneau suivant                             |
| C-q z       | resize-pane -Z         | zoom le panneau courant                                                |
| C-q M-o     | rotate-window -D       | inverse les panneaux                                                   |
| C-q R       | source-file .tmux.conf | Recharge le fichier de configuration sans quitter tmux                 |
| C-q M-Left  | resize-pane -L 5       | agrandit le panneau courant vers la gauche                             |
| C-q M-Right | resize-pane -R 5       | agrandit le panneau courant vers la droite                             |
| C-q M-Up    | resize-pane -U         | agrandit le panneau courant vers la haut                               |
| C-q M-Down  | resize-pane -D         | agrandit le panneau courant vers la bas                                |

</details>
