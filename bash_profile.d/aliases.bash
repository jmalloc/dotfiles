m () {
    RUN_ARGS="${*:2}" make "$1"
}

alias e='code .'
alias h='hive'
alias d='docker'

alias less='less -R'
alias grep='grep --color'

if type -t hub > /dev/null; then
     alias git=hub
fi

if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -lhG'
else
    alias ls='ls -lh --color --group-directories-first'
fi
