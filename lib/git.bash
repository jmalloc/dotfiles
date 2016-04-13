GIT_BINARY="$(which git)"
HUB_BINARY="$(which hub)"
GIT_SEARCH_COMPLETION=""
GIT_SEARCH_INDEX=()

git() {
    if [ "$1" == "cd" ]; then
        repo-chdir "${@:2}"
    elif [[ "$1" == "clone" && $# -eq 2 && "$2" =~ ^[^/:@]+/[^/]+$ ]]; then
        repo-clone "$2"
    elif [[ "$1" == "go" ]]; then
        repo-go-link "${@:2}"
    else
        "${HUB_BINARY:-$GIT_BINARY}" "$@"
    fi

    return $?
}

_git_cd() {
    [ -z "$GIT_SEARCH_COMPLETION" ] && repo-chdir --reindex
    COMPREPLY=( $(compgen -W "$GIT_SEARCH_COMPLETION" -- ${COMP_WORDS[COMP_CWORD]}) )
}

_git_clone() {
    [ -z "$GIT_SEARCH_COMPLETION" ] && repo-chdir --reindex
    COMPREPLY=( $(compgen -W "$GIT_SEARCH_COMPLETION" -- ${COMP_WORDS[COMP_CWORD]}) )
}

repo-go-link() {
    local slug=
    if ! slug=$(git slug); then
        echo "git-go: not an identifiable git repository" >&2
        return 1
    fi

    local link="$GOPATH/src/github.com/$slug"

    if [[ "$1" == "link" ]]; then
        if [ -e "$link" ]; then
            echo "git-go: $link already exists" >&2
            return 1
        fi

        mkdir -p "$(dirname "$link")"
        ln -s "$(pwd)" "$link"
    elif [[ "$1" == "unlink" ]]; then
        if [ ! -L "$link" ]; then
            echo "git-go: $link does not exist" >&2
            return 1
        fi

        unlink "$link"
    else
        echo "git-go: unknown subcommand" >&2
        return 255
    fi

    repo-chdir --reindex
    repo-chdir "$slug"
}

_git_go() {
    COMPREPLY=( $(compgen -W "link unlink" -- ${COMP_WORDS[COMP_CWORD]}) )
}

repo-chdir-index-has-path() {
    local index=0
    local count=${#GIT_SEARCH_INDEX[@]}

    while [ $index -lt $count ]; do
        local slug=${GIT_SEARCH_INDEX[$index]}; index=$((index + 1))
        local path=${GIT_SEARCH_INDEX[$index]}; index=$((index + 1))
        [[ "$(realpath "$path")" == "$(realpath "$1")" ]] && return 0
    done

    return 1
}

repo-chdir-index-add() {
    repo-chdir-index-has-path "$2" && return
    GIT_SEARCH_INDEX+=("$1")
    GIT_SEARCH_INDEX+=("$2")
}

repo-chdir-index-match() {
    local index=0
    local count=${#GIT_SEARCH_INDEX[@]}

    while [ $index -lt $count ]; do
        local slug=${GIT_SEARCH_INDEX[$index]}; index=$((index + 1))
        local path=${GIT_SEARCH_INDEX[$index]}; index=$((index + 1))
        [[ "$slug" == "$1" || "$(basename "$slug")" == "$1" ]] && echo "$path"
    done
}

repo-chdir() {
    if [[ "$1" == "--reindex" ]]; then
        GIT_SEARCH_COMPLETION=""
        GIT_SEARCH_INDEX=()

        local path=
        local slug=
        for path in $(find $GIT_SEARCH -mindepth 2 -maxdepth 2 -type d); do
            if slug="$(cd "$path"; git slug)"; then
                GIT_SEARCH_COMPLETION="$slug $(basename "$slug") $GIT_SEARCH_COMPLETION"
                repo-chdir-index-add "$slug" "$path"
            fi
        done

        GIT_SEARCH_COMPLETION=$(printf '%s\n' $GIT_SEARCH_COMPLETION | sort -u)
    elif [ -z "$1" ]; then
        cd "$GIT_PATH"
    else
        [ -z "$GIT_SEARCH_INDEX" ] && repo-chdir --reindex
        local matches=($(repo-chdir-index-match "$1"))

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

        echo "  $(color-lime)>>> $(color-magenta)$(git slug --fuzzy) $(color-dark-grey)found in $(color-blue)$(pwd)"
    fi
}

repo-clone() {
    local tmp=$(mktemp -d)
    local dir="$GIT_PATH/$1"

    if [ $# -ne 1 ]; then
        echo 'usage: git clone <github slug>'
        return 1
    fi

    local matches="$(repo-chdir-index-match "$1")"

    if [ ! -z "$matches" ]; then
        repo-chdir "$1"
    elif git clone "git@github.com:$1.git" "$tmp"; then
        mkdir -p "$(dirname "$dir")"
        mv "$tmp" "$dir"
        repo-chdir --reindex
        cd "$dir"
    else
        rmdir "$tmp"
        return 1
    fi
}
