alias less='less -R'
alias grep='grep --color'
alias heroky='heroku'

alias e='subl .'

alias d='git diff'
alias s='git status'
alias c='git commit -m'
alias a='git add'
alias A='git add -A'
alias p='git push'
alias P='git push --all --follow-tags'
alias u='git pull'
alias req='composer require --sort-packages'
alias cov='open artifacts/tests/coverage/index.html'

function C {
    git add -A && git commit -m "$1" && git push
}

alias t='./vendor/bin/phpunit --stop-on-failure'
alias o='phpdbg70 -qrr ./vendor/bin/phpunit -c phpunit.xml.coverage --stop-on-failure'

if [[ $(uname) == "Darwin" ]]; then
    alias ls='ls -lhG'
else
    alias ls='ls -lh --color --group-directories-first'
fi

if [ $(which hub 2> /dev/null) ]; then
    alias git='hub'
fi

if [ $(which git-flow 2> /dev/null) ]; then
    alias gfi='git checkout master && git flow init -d && git checkout develop'
fi

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
