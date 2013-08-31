PROMPT_COMMAND=build-prompt
DEFAULT_USERNAME=james

function build-prompt {
    ESCAPE_COLOR_CODES=true

    local auth=''
    if [[ $USER != $DEFAULT_USERNAME ]]; then
        auth=$(color-yellow $USER)
    fi

    if [ $SSH_TTY ]; then
        auth="${auth}$(color-yellow "@\h")"
    fi

    local location=$(color-blue "\w")
    local title=""

    if [ $(which git 2>/dev/null) ]; then
        local git=$(git-root)

        if [ "$git" ]; then
            local repo=$(git-repo)
            local branch=$(git-branch)
            local rev=$(git-rev)
            local path=$(git-path)
            title="$repo"

            if [[ $branch == "develop" ]]; then
                branch=$(color-white develop)
            elif [[ $branch == "master" ]]; then
                branch=$(color-red master)
            elif [[ $rev == "" ]]; then
                branch=$(color-yellow "<empty>")
            elif [[ $branch == "" ]]; then
                branch=$(color-red "<${rev}>")
            else
                branch=$(color-green $branch)
            fi

            location="$(color-magenta $repo) ${branch}"

            if [[ $path != "" ]]; then
                location="$location $(color-blue "$path")"
            fi
        fi
    fi

    local prompt="\[\033]0;${title}\007\]$(color-dark-grey "\A") $auth $location$(color-dark-grey :) $(color-reset)"

    if [[ $(uname) == "Darwin" ]]; then
        PS1=$(echo "$prompt" | sed -E "s/[ ]+/ /g")
    else
        PS1=$(echo "$prompt" | sed -r "s/[ ]+/ /g")
    fi

    ESCAPE_COLOR_CODES=false
}
