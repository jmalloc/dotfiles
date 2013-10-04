REAL_GIT=$(which git)

function git-root {
    $REAL_GIT rev-parse --show-toplevel 2> /dev/null
}

function git-path {
    $REAL_GIT rev-parse --show-prefix 2> /dev/null
}

function git-branch {
    $REAL_GIT branch --no-color 2> /dev/null | egrep '^\* [^\(]' | cut -c3-
}

function git-url {
    $REAL_GIT config --get remote.origin.url
}

function git-repo {
    git-url | egrep -o "[^/:]+/[^/]+.git$" | sed "s/.git$//" 2>/dev/null || basename $(git-root)
}

function git-rev-hash {
    $REAL_GIT rev-parse --short HEAD 2> /dev/null
}

function git-rev-tag {
    $REAL_GIT name-rev --name-only --tags --no-undefined HEAD 2> /dev/null
}

function git-rev-branch {
    $REAL_GIT name-rev --name-only --no-undefined HEAD 2>/dev/null
}

function git-rev {
    git-rev-tag || git-rev-branch || git-rev-hash
}

function git-clean {
    $REAL_GIT status 2>/dev/null | grep "working directory clean" > /dev/null
    return $?
}
