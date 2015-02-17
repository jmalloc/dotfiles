alias less='less -R'
alias grep='grep --color'
alias heroky='heroku'

alias e='subl .'

alias d='git checkout develop'
alias s='git status'
alias c='git commit -m'
alias a='git add -A'
alias p='git push'
alias u='git pull'

alias t='./vendor/bin/archer test --stop-on-failure'
alias o='./vendor/bin/archer cov --stop-on-failure'

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
