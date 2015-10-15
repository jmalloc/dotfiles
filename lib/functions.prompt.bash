PROMPT_COMMAND=build-prompt

function title {
    WINDOW_TITLE="$1"
}

function build-prompt {
    ESCAPE_COLOR_CODES=true

    local auth=""
    local title_auth=""

    if [[ ! "$DEFAULT_USERNAMES" =~ (^| )$USER($| ) ]]; then
        auth=$(color-gold $USER)
        title_auth=$USER
    fi

    if [ "$SSH_TTY" ]; then
        auth="${auth}$(color-gold "@\h")"
        title_auth="${title_auth}@$(hostname)"
    fi

    if [[ "$auth" != "" ]]; then
        auth=" ${auth}"
    fi

    local location=$(color-blue "\w")
    local title="$(basename "$(pwd)")"

    if [ "$REAL_GIT" ]; then
        local repo=$(git-repo)

        if [[ "$repo" != "" ]]; then
            local ahead=0
            local behind=0
            local rev_type;
            local rev_name;
            local rev;
            read -r rev_type rev_name rev <<< $(git-current-color)

            title="$repo"

            local stashes=$(echo $($REAL_GIT stash list | wc -l))

            # Current revision is a branch ...
            if [[ "branch" == "$rev_type" ]]; then
                ahead=$(echo $($REAL_GIT log --oneline "$rev_name" "^origin/$rev_name" 2> /dev/null | wc -l))
                behind=$(echo $($REAL_GIT log --oneline "origin/$rev_name" "^$rev_name" 2> /dev/null | wc -l))
            fi

            location="$(color-magenta $repo)"

            local status=""
            local statusSeparator=""

            if [[ "$behind" > 0 ]]; then
                status="${status}${statusSeparator}-${behind}"
                statusSeparator="/"
            fi

            if [[ "$ahead" > 0 ]]; then
                status="${status}${statusSeparator}+${ahead}"
                statusSeparator="/"
            fi

            if ! git-clean; then
                status="${status}${statusSeparator}*"
                statusSeparator="/"
            fi

            if [[ "$stashes" > 0 ]]; then
                status="${status}${statusSeparator}#${stashes}"
            fi

            if [ "$status" ]; then
                location="$location $(color-yellow "$status")"
            fi

            location="$location $rev"

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

    local newline=""

    if [ $(stty size | cut -d " " -f2) -lt 80 ]; then
        newline="\n"
    fi

    PS1="\n\[\033]0;${title}\007\]$(color-dark-grey "\A")$auth $location$newline$(color-dark-grey :) $(color-reset)"

    ESCAPE_COLOR_CODES=false
}
