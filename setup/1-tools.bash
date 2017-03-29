[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"

brew install \
    bash-completion \
    ghi \
    git \
    git-flow-avh \
    go \
    hub \
    hardlink-osx

gem install --user-install \
    travis
