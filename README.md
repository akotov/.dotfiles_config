# Installing onto a **new** system

Add repo source to .gitignore

    echo ".dotfiles_config" >> $HOME/.gitignore

Clone

    git clone --bare https://github.com/akotov/.dotfiles_config $HOME/.dotfiles_config


Add this alias to your .zshrc or .bashrc file.

    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles_config/ --work-tree=$HOME'

Checkout

    dotfiles checkout

mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}


# To **initialize** the dotfiles_config you need to do this

    git init --bare $HOME/.dotfiles_config
    dotfiles config status.showUntrackedFiles no


