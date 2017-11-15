if BREW_PREFIX=$(brew --prefix 2> /dev/null); then
    if [ -e "$BREW_PREFIX/etc/bash_completion" ]; then
        source "$BREW_PREFIX/etc/bash_completion"
        type -t __git_complete > /dev/null && __git_complete g __git_main
    fi
fi
