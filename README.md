To checkout the dotfiles repo to an existing home directory:

    cd ~
    git init
    git remote add origin git@github.com:jmalloc/dotfiles.git
    git fetch origin
    git checkout master --force # Warning: blows away local files (ie .bash_profile, etc).
