function C {
    git add -A && git commit -m "$1" && git push
}

alias e='subl .'
alias m='make'
alias less='less -R'
alias grep='grep --color'
alias cov='open artifacts/tests/coverage/index.html'

if [[ $(uname) == "Darwin" ]]; then
    alias ls='ls -lhG'
else
    alias ls='ls -lh --color --group-directories-first'
fi

if [ $(which hub 2> /dev/null) ]; then
    alias git='hub'
    alias g='hub'
else
    alias g='git'
fi

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
