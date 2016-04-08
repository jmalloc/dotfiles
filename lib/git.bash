GIT_SEARCH_COMPLETION=""
GIT_SEARCH_INDEX=()

repo-name() {
    if ! url="$(cd "${1:-.}"; git config --get remote.origin.url)"; then
        return 1
    fi

    if [[ "$url" =~ :(.+/.+)\.git$ ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        echo "???/$(basename "$(pwd)")"
    fi
}

repo-chdir() {
    if [[ "$1" == "--reindex" ]]; then
        GIT_SEARCH_COMPLETION=""
        GIT_SEARCH_INDEX=()

        local dir=
        local subdir=
        local name=
        local shortname=

        for dir in $GIT_SEARCH; do
            if [ -d "$dir" ]; then
                for subdir in $(find -L "$dir" -mindepth 2 -maxdepth 2); do
                    if name="$(repo-name "$subdir")"; then
                        shortname="$(basename "$name")"
                        GIT_SEARCH_COMPLETION="$name $shortname $GIT_SEARCH_COMPLETION"
                        GIT_SEARCH_INDEX+=("$name")
                        GIT_SEARCH_INDEX+=("$shortname")
                        GIT_SEARCH_INDEX+=("$subdir")
                    fi
                done
            fi
        done
    elif [ -z "$1" ]; then
        cd "$GIT_DIR"
    else
        [ -z "$GIT_SEARCH_INDEX" ] && repo-chdir --reindex

        local index=0
        local count=${#GIT_SEARCH_INDEX[@]}
        local matches=()

        while [ $index -lt $count ]; do
            local name=${GIT_SEARCH_INDEX[$index]}
            index=$((index + 1))
            local shortname=${GIT_SEARCH_INDEX[$index]}
            index=$((index + 1))
            local path=${GIT_SEARCH_INDEX[$index]}
            index=$((index + 1))

            if [[ "$name" == "$1" || "$shortname" == "$1" ]]; then
                matches+=($path)
            fi
        done

        if [ ${#matches[@]} -eq 0 ]; then
            echo "  $(color-maroon)!!! $(color-dark-grey)Repository $(color-grey)$1 $(color-dark-grey)does not exist.$(color-reset)"
            return 1
        elif [ ${#matches[@]} -eq 1 ]; then
            cd ${matches[0]}
        else
            echo "  $(color-orange)??? $(color-dark-grey)Found $(color-grey)${#matches[@]} $(color-dark-grey)repositories matching $(color-grey)$1$(color-dark-grey):$(color-grey)"
            echo
            local PS3="$(color-reset): "
            local path=
            select path in ${matches[@]}; do
                if [ ! -z $path ]; then
                    cd $path
                    break
                fi
            done
        fi

        echo "  $(color-lime)>>> $(color-magenta)$(repo-name) $(color-dark-grey)found in $(color-blue)$(pwd)"
    fi
}

repo-clone() {
    local tmp=$(mktemp -d)
    local dir="$GIT_PATH/$1"

    if [ $# -ne 1 ]; then
        echo 'usage: git cl <organisation/repo>'
        return 1
    fi

    if git clone "git@github.com:$1.git" "$tmp"; then
        mkdir -p "$(dirname "$dir")"
        mv "$tmp" "$dir"
        repo-chdir --reindex
        cd "$dir"
    else
        rmdir "$tmp"
        return 1
    fi
}

export GIT_BINARY="$(which git)"
export HUB_BINARY="$(which hub)"

git() {
    if [ "$1" == "cd" ]; then
        repo-chdir "${@:2}"
    elif [[ "$1" == "clone" && $# -eq 2 && "$2" =~ ^[^/:@]+/[^/]+$ ]]; then
        repo-clone "$2"
    else
        "${HUB_BINARY:-$GIT_BINARY}" "$@"
    fi

    return $?
}

# This function is called by the standard git completion installed with brew ...
_git_cd() {
    [ -z "$GIT_SEARCH_COMPLETION" ] && repo-chdir --reindex
    COMPREPLY=( $(compgen -W "$GIT_SEARCH_COMPLETION" -- ${COMP_WORDS[COMP_CWORD]}) )
}

__git_complete g __git_main
