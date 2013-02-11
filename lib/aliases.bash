function goto {
    local base=~/Documents/Development
    if [ ! -d $base ]; then
        base=~/Documents
    fi

    local path=
    local projects=
    local multiple=

    if [ -d "${base}/${1}" ]; then
        path="${base}/${1}"
        projects=$1
    else
        for dir in $base/*; do
            if [ -d "${dir}/${1}" ]; then
                if [ $path ]; then
                    multiple=true
                else
                    path="${dir}/${1}"
                fi
                projects="$(basename $dir)/${1} ${projects}"
            fi
        done
    fi

    if [ $multiple ]; then
        color-red "Multiple projects found:"
        color-reset
        echo
        for project in $projects; do
            echo " * ${project}"
        done
        return 1
    elif [[ "$1" != "" && "$path" == "" ]]; then
        color-red "No such project."
        echo
    else
        cd $path
    fi
}

alias less='less -r'
alias ls='ls -G'

if [ $(which git-flow) ]; then
    alias gf='git flow'
    alias gfi='git checkout master && git flow init -d'
    alias gff='git flow feature'
    alias gfr='git flow release'
    alias gfh='git flow hotfix'
    alias gfs='git flow support'
fi

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
