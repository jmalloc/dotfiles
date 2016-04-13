##
## ENVIRONMENT
##
export USERNAMES="james jmalloc"
export DOTFILES_PATH="$HOME/dotfiles"                # The path to the clone of this repo.
export GIT_PATH="$HOME/dev/git"                      # The target for 'git cl' clones.
export GOPATH="$HOME/dev/go"
export GIT_SEARCH="$GOPATH/src/github.com $GIT_PATH" # Search paths for 'git cd'.
export PATH="$DOTFILES_PATH/bin:$HOME/bin:$HOME/.gem/ruby/2.0.0/bin:$GOPATH/bin:/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export HISTCONTROL="ignoreboth"
export ICLOUD_DRIVE_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

[ -d "$ICLOUD_DRIVE_PATH" ] && export HAS_ICLOUD=true
type -t git-upload-pack > /dev/null && export HAS_GIT=true # git() function might already be defined, so check for git-upload-pack
type -t hub  > /dev/null && export HAS_HUB=true
type -t brew > /dev/null && export HAS_BREW=true
type -t atom > /dev/null && export HAS_ATOM=true
type -t subl > /dev/null && export HAS_SUBL=true
type -t composer > /dev/null && export HAS_COMPOSER=true

ulimit -n 8192

##
## ALIASES
##
alias g='git'
alias m='make'
alias less='less -R'
alias grep='grep --color'
alias cov='open artifacts/tests/coverage/index.html'

if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -lhG'
else
    alias ls='ls -lh --color --group-directories-first'
fi

if [ -e "$(brew --prefix)/etc/bash_completion" ]; then
    source $(brew --prefix)/etc/bash_completion
    type -t __git_complete > /dev/null && __git_complete g __git_main
fi

##
## TEXT EDITOR
##
export EDITOR="vim"

if [ $HAS_ATOM ]; then
    alias e='atom .'
elif [ $HAS_SUBL ]; then
    alias e='subl .'
    export EDITOR='subl -w'
fi

export VISUAL="$EDITOR"

if [ $HAS_ICLOUD ]; then
    if [[ $HAS_ATOM && ! -L "$HOME/.atom" ]]; then
        [ -e "$HOME/.atom" ] && mv "$HOME/.atom" "$HOME/.Trash/dotfiles.atom.$(date +%s)"
        ln -s "$ICLOUD_DRIVE_PATH/atom" "$HOME/.atom"
    fi

    P="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
    if [[ $HAS_SUBL && ! -L "$P" ]]; then
        [ -e "$P" ] && mv "$P" "$HOME/.Trash/dotfiles.sublime.$(date +%s)"
        ln -s "$ICLOUD_DRIVE_PATH/sublime" "$P"
    fi
fi

##
## Source other bash scripts ...
##
for FILE in "$DOTFILES_PATH/lib/"*.bash; do
    source $FILE
done

touch "$HOME/.hushlogin" # hide the "last login" banner
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

##
## .bashrc SHOULD set the GITHUB_TOKEN environment variable to make it available
## to homebrew and composer without comitting it to the repo.
##
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Warning: GITHUB_TOKEN is not set."
else
    export HOMEBREW_GITHUB_API_TOKEN="$GITHUB_TOKEN"
    [ $HAS_COMPOSER ] && composer config --global -- github-oauth.github.com "$GITHUB_TOKEN"
fi

if LS=$(ls -ld "$HOME"/.Trash/dotfiles.* 2> /dev/null); then
    echo "$(color-orange)$LS$(color-reset)"
fi
