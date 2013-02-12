function util-dev-folder {
    if [ -d ~/Documents/Development/icecave ]; then
        echo ~/Documents/Development
    elif [ -d ~/Documents/icecave ]; then
        echo ~/Documents
    fi
}

# Open a github repo in browser ...
function ropen {
    open "https://github.com/$(git-repo)"
}

# Clone a repo from github
function rclone {
    local dir=$1
    local repo=$2
    local base="$(util-dev-folder)/${dir}"
    local account=$dir

    if [[ $dir == "icecave" ]]; then
        account="IcecaveStudios"
    fi

    mkdir -p $base
    cd $base
    git clone "git@github.com:${account}/${repo}.git"
    cd $repo
}

# CHange directory to a repo ...
function rcd {
    local base=$(util-dev-folder)
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
