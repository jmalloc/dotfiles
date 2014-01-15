GIT_DIR_CACHE=""

# Clone a repo from GitHub into the appropriate directory.
function rclone {
    local repo=$1
    local dir="${GIT_DIR_GITHUB}/${repo}"

    mkdir -p "$(dirname $dir)"
    hub clone -p $repo $dir

    rcd-reindex
    rcd $repo
}

# Clone a repo from Stash into the appropriate directory.
function rclone-cwx {
    local repo=$1
    local dir="${GIT_DIR_CWX}/${repo}"
    local url="ssh://git@stash.codeworx.com.au:7999/${repo}.git"

    mkdir -p "$(dirname $dir)"
    git clone $url $dir

    rcd-reindex
    rcd $repo
}

# Open coverage reports in a browser ...
function rcov {
    open artifacts/tests/coverage/index.html
}

# Open a repo in the browser ...
function ropen {
    if ! (hub browse &> /dev/null); then
        local repo=$(git-repo)
        local project=$(dirname $repo)
        local slug=$(basename $repo)
        open https://stash.codeworx.com.au/projects/${project}/repos/${slug}/browse
    fi
}

# Open a repo in Travis CI web interface ...
function rtravis {
    open https://travis-ci.org/$(git-repo)/builds
}

# Change directory into a git clone ...
function rcd {
    local name=$1

    if [ -z $name ]; then
        return
    fi

    local base=
    local matches=
    local count=

    if [[ $count == "" ]]; then
        for base in $GIT_DIR_LIST; do
            if [ -d $base ]; then
                matches=$(find $base -mindepth 2 -maxdepth 2 -type d -iname $name)
                count=$(echo $matches | wc -w | tr -d ' ')

                if [ $count -gt 0 ]; then
                    break
                fi
            fi
        done
    fi

    if [[ $count -eq 0 ]]; then
        for base in $GIT_DIR_LIST; do
            if [ -d "${base}/${name}" ]; then
                matches="${base}/${name}"
                count=1
                break
            fi
        done
    fi

    if [[ $count == "" ]]; then
        count=0
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
        echo "  $(color-orange)??? $(color-dark-grey)Found $(color-grey)${count} $(color-dark-grey)repositories matching $(color-grey)${name}$(color-dark-grey):"
        local options=""
        for repo in $matches; do
            options="$options $(echo $repo | cut -c$(expr 2 + ${#base})-)"
        done

        color-magenta

        local PS3="$(color-reset): "
        select repo in $options; do
            if [ ! -z $repo ]; then
                cd "${base}/${repo}"
                break
            fi
        done
    fi

    color-reset
}

function rcd-reindex {
    GIT_DIR_CACHE=""
    for base in $GIT_DIR_LIST; do
        if [ -d $base ]; then
            for dir in $(find $base -mindepth 2 -maxdepth 2 -type d); do
                local repo=$(echo $dir | rev | cut -d/ -f1-2 | rev)
                GIT_DIR_CACHE="$repo $(basename "$repo") $GIT_DIR_CACHE"
            done
        fi
    done
}

function __rcd-completion {
    if [[ "$GIT_DIR_CACHE" == "" ]]; then
        rcd-reindex
    fi

    COMPREPLY=( $(compgen -W "$GIT_DIR_CACHE" -- ${COMP_WORDS[COMP_CWORD]}) )
}

complete -F __rcd-completion rcd
