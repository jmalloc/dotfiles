##
## ENVIRONMENT
##
export USERNAMES="james jmalloc"
export DOTFILES_PATH="$HOME/dotfiles" # The path to the clone of this repo.
export GOPATH="$HOME/dev/go"
export PATH="$DOTFILES_PATH/bin:$HOME/bin:$HOME/.gem/ruby/2.0.0/bin:$PATH"
export HISTCONTROL="ignoreboth"
export ICLOUD_DRIVE_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

[ -d "$ICLOUD_DRIVE_PATH" ] && export HAS_ICLOUD=true
type -t git > /dev/null && export HAS_GIT=true
type -t hub > /dev/null && export HAS_HUB=true
type -t composer > /dev/null && export HAS_COMPOSER=true
type -t docker > /dev/null && export HAS_DOCKER=true
type -t grit > /dev/null && export HAS_GRIT=true

if BREW_PREFIX=$(brew --prefix 2> /dev/null); then
    export HAS_BREW=true
    export BREW_PREFIX="$BREW_PREFIX"
fi

[ $HAS_GRIT ] && eval "$(grit shell-integration)"

ulimit -n 8192

##
## ALIASES
##
alias e='atom .'
alias g='git'
alias m='make'
alias less='less -R'
alias grep='grep --color'
alias cov='open artifacts/tests/coverage/index.html'
[ $HAS_HUB ] && alias git=hub

if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -lhG'
else
    alias ls='ls -lh --color --group-directories-first'
fi

if [ -e "$BREW_PREFIX/etc/bash_completion" ]; then
    source "$BREW_PREFIX/etc/bash_completion"
    type -t __git_complete > /dev/null && __git_complete g __git_main
fi

export EDITOR="vim"
export VISUAL="$EDITOR"

if [[ $HAS_ICLOUD && $HAS_ATOM && ! -L "$HOME/.atom" ]]; then
    [ -e "$HOME/.atom" ] && mv "$HOME/.atom" "$HOME/.Trash/dotfiles.atom.$(date +%s)"
    ln -s "$ICLOUD_DRIVE_PATH/atom" "$HOME/.atom"
fi

##
## Source other bash scripts ...
##
for FILE in "$DOTFILES_PATH/lib/"*.bash; do
    source $FILE
done

[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

##
## .bashrc SHOULD set the GITHUB_COM_TOKEN environment variable to make it available
## to homebrew and composer without comitting it to the repo.
##
if [ -z "$GITHUB_COM_TOKEN" ]; then
    echo "Warning: GITHUB_COM_TOKEN is not set."
else
    export HOMEBREW_GITHUB_API_TOKEN="$GITHUB_COM_TOKEN"
    [ $HAS_COMPOSER ] && composer config --global -- github-oauth.github.com "$GITHUB_COM_TOKEN"
fi

if [ ! -z "$GITHUB_CWX_DOMAIN" ]; then
    [ $HAS_GIT ] && git config --global --replace-all hub.host "$GITHUB_CWX_DOMAIN"

    if [ $HAS_COMPOSER ]; then
        composer config --global github-domains github.com "$GITHUB_CWX_DOMAIN"
        composer config --global -- "github-oauth.${GITHUB_CWX_DOMAIN}" "$GITHUB_COM_TOKEN"
    fi
fi

if LS=$(ls -ld "$HOME"/.Trash/dotfiles.* 2> /dev/null); then
    echo "$(color-orange)$LS$(color-reset)"
fi
