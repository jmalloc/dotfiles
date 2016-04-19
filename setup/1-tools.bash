[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"
[ -e "$HOME/dev/git" ] || mkdir -p "$HOME/dev/git"

brew install \
    bash-completion \
    git \
    git-flow-avh \
    go \
    hub

gem install --user-install \
    ghi \
    travis
