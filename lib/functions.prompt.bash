PROMPT_COMMAND=build-prompt
DEFAULT_USERNAME=james

function title {
    WINDOW_TITLE="$1"
}

function build-prompt {
    ESCAPE_COLOR_CODES=true

    local auth=""
    local title_auth=""

    if [[ "$USER" != "$DEFAULT_USERNAME" ]]; then
        auth=$(color-yellow $USER)
        title_auth=$USER
    fi

    if [ "$SSH_TTY" ]; then
        auth="${auth}$(color-yellow "@\h")"
        title_auth="${title_auth}@$(hostname)"
    fi

    if [[ "$auth" != "" ]]; then
        auth=" ${auth}"
    fi

    local location=$(color-blue "\w")
    local title="$(basename $(pwd))"

    if [ "$REAL_GIT" ]; then
        local repo=$(git-repo)

        if [[ "$repo" != "" ]]; then
            local branch=$(git-branch)
            local ahead=$(echo $($REAL_GIT log --oneline "$branch" "^origin/$branch" 2>/dev/null | wc -l))
            local behind=$(echo $($REAL_GIT log --oneline "origin/$branch" "^$branch" 2>/dev/null | wc -l))

            title="$repo"

            if [[ "$branch" == "develop" ]]; then
                branch=$(color-white develop)
            elif [[ "$branch" == "master" ]]; then
                branch=$(color-red master)
            else
                local rev=$(git-rev)
                if [[ "$rev" == "" ]]; then
                    branch=$(color-yellow "<empty>")
                elif [[ "$branch" == "" ]]; then
                    branch=$(color-red "<${rev}>")
                else
                    branch=$(color-green $branch)
                fi
            fi

            location="$(color-magenta $repo)"

            local status=""
            local statusSeperator=""

            if [[ "$behind" > 0 ]]; then
                status="${status}${statusSeperator}-${behind}"
                statusSeperator="/"
            fi

            if [[ "$ahead" > 0 ]]; then
                status="${status}${statusSeperator}+${ahead}"
                statusSeperator="/"
            fi

            if ! git-clean; then
                status="${status}${statusSeperator}*"
            fi

            if [ "$status" ]; then
                location="$location $(color-yellow "$status")"
            fi

            location="$location $branch"

            local path=$(git-path)
            if [[ "$path" ]]; then
                location="$location $(color-blue "$path")"
            fi
        fi
    fi

    if [ "$WINDOW_TITLE" ]; then
        title="$WINDOW_TITLE"
    elif [ "$title_auth" ]; then
        title="${title} - ${title_auth}"
    fi

    PS1="\[\033]0;${title}\007\]$(color-dark-grey "\A")$auth $location$(color-dark-grey :) $(color-reset)"

    ESCAPE_COLOR_CODES=false
}
