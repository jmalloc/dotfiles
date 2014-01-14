alias less='less -R'
alias grep='grep --color'
alias heroky='heroku'

if [[ $(uname) == "Darwin" ]]; then
    alias ls='ls -lhG'
else
    alias ls='ls -lh --color --group-directories-first'
fi

if [ $(which hub 2> /dev/null) ]; then
    alias git='hub'
fi

if [ $(which git-flow 2> /dev/null) ]; then
    alias gf='git flow'
    alias gfi='git checkout master && git flow init -d && git checkout develop'
    alias gff='git flow feature'
    alias gfr='git flow release'
    alias gfh='git flow hotfix'
    alias gfs='git flow support'
fi

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
