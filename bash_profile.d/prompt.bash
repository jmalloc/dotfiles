if [ -n "$PROMPT_COMMAND" ]; then
    PROMPT_COMMAND="${PROMPT_COMMAND};"
fi

if type -t git > /dev/null; then
    PROMPT_COMMAND="${PROMPT_COMMAND}build-prompt-git"
else
    PROMPT_COMMAND="${PROMPT_COMMAND}build-prompt"
fi

if [[ ! "$USERNAMES" =~ (^| )"$USER"($| ) ]]; then
    PROMPT_AUTH=$(color-gold $USER)
    TITLE_AUTH=$USER
fi

if [ ! -z "$SSH_TTY" ]; then
    PROMPT_AUTH="$PROMPT_AUTH$(color-gold "@\h")"
    TITLE_AUTH="$TITLE_AUTH@$(hostname)"
fi

[ ! -z "$PROMPT_AUTH" ] && PROMPT_AUTH=" $PROMPT_AUTH"
[ ! -z "$TITLE_AUTH" ] && TITLE_AUTH=" - $TITLE_AUTH"

_git-slug() {
    if ! URL="$(git config --get remote.origin.url)"; then
        return 1
    fi

    if [[ "$URL" =~ [:/]([^/:]+/[^/]+)\.git$ ]]; then
        echo "${BASH_REMATCH[1]}"
    elif [[ "$1" == '--fuzzy' ]]; then
        echo "???/$(basename "$(pwd)")"
    else
        return 1
    fi
}

build-prompt() {
    ESCAPE_COLOR_CODES=true
    PS1="\n\[\033]0;$(basename "$(pwd)")$TITLE_AUTH\007\]$(color-dark-grey "\A")$PROMPT_AUTH $(color-blue "\w")$(build-prompt-newline)$(color-dark-grey :) $(color-reset)"
    ESCAPE_COLOR_CODES=false
}

build-prompt-git() {
    local status="$(git status -sb 2> /dev/null)"

    if [ -z "$status" ]; then
        build-prompt
        return
    fi

    ESCAPE_COLOR_CODES=true

    local repo=$(_git-slug --fuzzy)
    local ahead=0
    local behind=0
    local stash=$(echo $(git stash list | wc -l))
    local files=$(echo $(wc -l <<< "$status"))
    [[ "$status" =~ ahead.([0-9]+) ]] && ahead=${BASH_REMATCH[1]}
    [[ "$status" =~ behind.([0-9]+) ]] && behind=${BASH_REMATCH[1]}

    local status_string=""
    [ $ahead -gt 0 ] && status_string="$status_string $(color-green "+")$(color-lime $ahead)"
    [ $behind -gt 0 ] && status_string="$status_string $(color-maroon "-")$(color-red $behind)"
    [ $stash -gt 0 ] && status_string="$status_string $(color-dark-blue "#")$(color-blue $stash)"
    [ $files -gt 1 ] && status_string="$status_string $(color-gold "*")$(color-yellow $(($files - 1)))"
    (git log -1 --format=%B 2>/dev/null | egrep "^WIP\b" > /dev/null) && status_string="$status_string $(color-red "[WIP]")"

    local subdir="$(git rev-parse --show-prefix)"
    [ ! -z "$subdir" ] && subdir=" $(color-blue $subdir)"

    # It's a branch ...
    local rev=
    if rev="$(git symbolic-ref --short HEAD 2> /dev/null)"; then
        if [[ "$rev" == "master" ]]; then
            rev="$(color-orange master)"
        else
            rev="$(color-lime "$rev")"
        fi
    else
        rev="$(git name-rev --name-only HEAD)"

        if [[ "$rev" =~ ^tags/(.+)\^0$ ]]; then
            rev="$(color-maroon "@${BASH_REMATCH[1]}")"
        elif [[ "$rev" =~ ^tags/(.+\~[0-9]+)$ ]]; then
            rev="$(color-maroon "<@${BASH_REMATCH[1]}>")"
        else
            rev="$(color-maroon "<$rev>")"
        fi
    fi

    PS1="\n\[\033]0;$repo$TITLE_AUTH\007\]$(color-dark-grey "\A")$PROMPT_AUTH $(color-magenta "$repo") $rev$subdir$status_string$(build-prompt-newline)$(color-dark-grey :) $(color-reset)"

    ESCAPE_COLOR_CODES=false
}

build-prompt-newline() {
    [ ${COLUMNS:-$(tput cols)} -lt 100 ] && echo '\n'
}
