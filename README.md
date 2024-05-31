To initialize the dotfiles_config you need to do this:

    git init --bare $HOME/.dotfiles_config
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles_config/ --work-tree=$HOME'
    config config status.showUntrackedFiles no

Then add this alias to your .zshrc or .bashrc file.


