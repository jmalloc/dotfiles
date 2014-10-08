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

function git-current-color {
    local rev_type=
    local rev_name=
    local rev=
    read rev_type rev_name <<< $(git-current)

    if [[ "branch" == "$rev_type" ]]; then
        if [[ "develop" == "$rev_name" ]]; then
            rev=$(color-white develop)
        elif [[ "master" == "$rev_name" ]]; then
            rev=$(color-orange master)
        else
            rev=$(color-green $rev_name)
        fi
    # Current revision is a tag ...
    elif [[ "tag" == "$rev_type" ]]; then
        rev=$(color-orange "<$rev_name>")

    # Current revision is relative to a tag or branch ...
    elif [[ "relative" == "$rev_type" ]]; then
        rev=$(color-red "<$rev_name>")

    # No commits ...
    else
        rev=$(color-red "<empty>")
    fi

    if [ -z "$rev_type" ]; then
        rev_type="-"
    fi

    if [ -z "$rev_name" ]; then
        rev_name="-"
    fi

    echo "$rev_type" "$rev_name" "$rev"
}

function git-clean {
    $REAL_GIT status 2> /dev/null | grep "working directory clean" > /dev/null
    return $?
}

function git-merged-branches {
    local branches=$(git branch -r --merged | egrep -o "origin/(feature|release|hotfix|support)/[^ ]+")
    for branch in $branches; do
        echo $(git log -n1 $branch);
    done
}
