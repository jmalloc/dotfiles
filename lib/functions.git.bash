REAL_GIT=$(which git)

function git-root {
    $REAL_GIT rev-parse --show-toplevel 2> /dev/null
}

function git-path {
    $REAL_GIT rev-parse --show-prefix 2> /dev/null
}

function git-url {
    $REAL_GIT config --get remote.origin.url
}

function git-repo {
    git-url | egrep -o "[^/:]+/[^/]+.git$" | sed "s/.git$//" 2> /dev/null || basename $(git-root)
}

function git-current-branch {
    local rev=$($REAL_GIT branch --no-color 2> /dev/null | egrep '^\* [^\(]' | cut -c3-)
    if [[ "" != "$rev" ]]; then
        echo "branch $rev"
        return 0
    fi

    return 1
}

function git-current-tag {
    local rev=$($REAL_GIT describe --tags --exact-match 2> /dev/null)
    if [[ "" != "$rev" ]]; then
        echo "tag $rev"
        return 0
    fi

    return 1
}

function git-current-relative-to-tag {
    local rev=$($REAL_GIT name-rev --name-only --tags --no-undefined HEAD 2> /dev/null)
    if [[ "" != "$rev" ]]; then
        echo "relative $rev"
        return 0
    fi

    return 1
}

function git-current-relative-to-branch {
    local rev=$($REAL_GIT name-rev --name-only --no-undefined HEAD 2> /dev/null)
    if [[ "" != "$rev" ]]; then
        echo "relative $rev"
        return 0
    fi

    return 1
}

function git-current {
    git-current-branch || git-current-tag || git-current-relative-to-tag || git-current-relative-to-branch
}

function git-clean {
    $REAL_GIT status 2> /dev/null | grep "working directory clean" > /dev/null
    return $?
}
