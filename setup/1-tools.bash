[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"
[ -e "$HOME/dev/github" ] || mkdir -p "$HOME/dev/github"

type -t brew > /dev/null || \
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install \
    bash-completion \
    git \
    go \
    hub

gem install --user-install \
    ghi \
    travis
