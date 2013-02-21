function github-directory {
    echo ~/Documents/GitHub
}

# Clone a repo from GitHub into the appropriate directory.
function rclone {
    local repo=$1
    local dir="$(github-directory)/${repo}"

    mkdir -p "$(dirname $dir)"
    hub clone -p $repo $dir
    rcd $repo
}

# Open coverage reports in a browser.
function rcov {
    open artifacts/tests/coverage/index.html
}

function ropen {
    hub browse "$@"
}

# Change directory into a GitHub repo clone.
function rcd {
    local name=$1
    local base=$(github-directory)
    local matches=
    local count=

    if [ -z $name ]; then
        cd $base
        return
    fi

    # Explicitly named ...
    if [ -d "${base}/${name}" ]; then
        matches="${base}/${name}"
        count=1
    else
        matches=$(find $base -iname $name -depth 2)
        count=$(echo $matches | wc -w | tr -d ' ')
    fi

    if [ $count -eq 1 ]; then
        cd $matches
        repo=$(git-repo)
        if [ ! -z $repo ]; then
            echo "  $(color-green)>>> $(color-magenta)$repo $(color-dark-grey)found in $(color-blue)$(pwd)"
        fi
    elif [ $count -eq 0 ]; then
        echo "  $(color-red)!!! $(color-dark-grey)Repository $(color-grey)${name} $(color-dark-grey)does not exist."
    else
        echo "  $(color-yellow)??? $(color-dark-grey)Found $(color-grey)${count} $(color-dark-grey)repositories matching $(color-grey)${name}$(color-dark-grey):"
        for repo in $matches; do
            echo "    $(color-yellow)- $(color-magenta)$(echo $repo | cut -c$(expr 2 + ${#base})-)"
        done
    fi

    color-reset
}
