alias less='less -R'
alias grep='grep --color'
alias heroky='heroku'
alias e='subl .'
alias d='git checkout develop'

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
