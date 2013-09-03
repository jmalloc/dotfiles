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

    if [[ $auth != "" ]]; then
        auth=" ${auth}"
    fi

    local location=$(color-blue "\w")
    local title=""

    if [ $REAL_GIT ]; then
        local repo=$(git-repo)

        if [[ $repo != "" ]]; then
            local branch=$(git-branch)
            title="$repo"

            if [[ $branch == "develop" ]]; then
                branch=$(color-white develop)
            elif [[ $branch == "master" ]]; then
                branch=$(color-red master)
            else
                local rev=$(git-rev)
                if [[ $rev == "" ]]; then
                    branch=$(color-yellow "<empty>")
                elif [[ $branch == "" ]]; then
                    branch=$(color-red "<${rev}>")
                else
                    branch=$(color-green $branch)
                fi
            fi

            location="$(color-magenta $repo) ${branch}"

            local path=$(git-path)
            if [[ $path != "" ]]; then
                location="$location $(color-blue "$path")"
            fi
        fi
    fi

    PS1="\[\033]0;${title}\007\]$(color-dark-grey "\A")$auth $location$(color-dark-grey :) $(color-reset)"

    ESCAPE_COLOR_CODES=false
}
