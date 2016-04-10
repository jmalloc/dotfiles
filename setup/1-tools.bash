[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"
[ -e "$HOME/dev/github" ] || mkdir -p "$HOME/dev/github"

brew install \
    bash-completion \
    git \
    go \
    hub

gem install --user-install \
    ghi \
    travis
