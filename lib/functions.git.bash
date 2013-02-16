function git-root {
    git rev-parse --show-toplevel 2> /dev/null
}

function git-path {
    local root=$(git-root)
    if [[ "$root" ]]; then
        echo $(pwd | cut -c$(expr 1 + ${#root})-)
    fi
}

function git-branch {
    git branch --no-color 2> /dev/null | egrep '^\* [^\(]' | cut -c3-
}

function git-repo {
    git config --list | grep remote.origin.url | egrep -o "[^/:]+/[^/]+.git" | sed "s/.git//g" 2>/dev/null \
    || basename $(git-root)
}

function git-rev-hash {
    git rev-parse --short HEAD 2> /dev/null
}

function git-rev-tag {
    git name-rev --name-only --tags --no-undefined HEAD 2> /dev/null
}

function git-rev-branch {
    git name-rev --name-only --no-undefined HEAD 2>/dev/null
}

function git-rev {
    git-rev-tag || git-rev-branch || git-rev-hash
}
