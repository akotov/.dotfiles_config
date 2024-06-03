# Installing onto a **new** system

Add repo source to .gitignore

    echo ".dotfiles_config" >> $HOME/.gitignore

Clone

    git clone --bare git@github.com:akotov/.dotfiles_config.git $HOME/.dotfiles_config
    dotfiles config --local status.showUntrackedFiles no


Add this alias to your .zshrc or .bashrc file.

    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles_config/ --work-tree=$HOME'

Checkout

    dotfiles checkout

Backup previous

    mkdir -p .dotfiles_config_backup && \
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | while read file; do
        dir=$(dirname ".dotfiles_config_backup/$file")
        mkdir -p "$dir"
        mv "$file" ".dotfiles_config_backup/$file"
    done

# To **initialize** the dotfiles_config you need to do this

    git init --bare $HOME/.dotfiles_config
    dotfiles config status.showUntrackedFiles no


