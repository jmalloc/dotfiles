function build-prompt {

    local RED='\[\033[00;31m\]'
    local GREEN='\[\033[00;32m\]'
    local YELLOW='\[\033[01;33m\]'
    local BLUE='\[\033[01;34m\]'
    local WHITE='\[\033[01;37m\]'
    local RESET='\[\033[00m\]'

    local USER_INFO=
    local USER_SEPARATOR=
    local HOST_INFO=
    local HOST_SEPARATOR=

    local LOCATION="${BLUE}\w${RESET}"

    # Only show username if it's not usual account name ...
    if [[ "${USER}" != "james" ]]; then
        USER_INFO="${YELLOW}${USER}${RESET}"
        USER_SEPARATOR="@"
        HOST_SEPARATOR=" "
    fi

    # Only show host info if remote connection ...
    if [[ "$SSH_TTY" != "" ]]; then
        HOST_INFO="${YELLOW}${USER_SEPARATOR}\h${RESET}"
        HOST_SEPARATOR=" "
    fi

    # Show path relative to repository root if inside git folders ...
    # local BRANCH=$(git name-rev --name-only HEAD 2>/dev/null)
    local BRANCH=$(git branch 2>/dev/null | egrep '^\*' | cut -c3-)
    local BRANCH_INFO=

    if [[ $BRANCH != "" ]]; then

        local GIT_ROOT="$(git rev-parse --show-toplevel)"
        local REPO_NAME="$(basename $GIT_ROOT)"

        if [[ "$(pwd)" == $GIT_ROOT ]]; then
            local CURRENT_DIR=""
        else
            local CURRENT_DIR=" $(pwd | cut -c$(expr 2 + ${#GIT_ROOT})-)"
        fi

        local NAME_REV=

        if [[ $BRANCH == "(no branch)" ]]; then
            NAME_REV=$(git name-rev --name-only --tags --no-undefined HEAD 2>/dev/null)
        fi

        if [[ $NAME_REV == "" ]]; then
            NAME_REV=$(git name-rev --name-only --no-undefined HEAD 2>/dev/null)
        fi

        if [[ $NAME_REV == "" ]]; then
            NAME_REV=$(git rev-parse --short HEAD)
        fi

        if [[ $BRANCH == "develop" ]]; then
            local BRANCH_INFO="${GREEN}develop${RESET}"
        elif [[ $BRANCH == "master" ]]; then
            local BRANCH_INFO="${YELLOW}master${RESET}"
        elif [[ $BRANCH == "(no branch)" ]]; then
            local BRANCH_INFO="${RED}${NAME_REV}${RESET}"
        else
            local BRANCH_INFO="${WHITE}${BRANCH}${RESET}"
        fi

        LOCATION="${GREEN}${REPO_NAME}${RESET} $BRANCH_INFO${BLUE}${CURRENT_DIR}${RESET}"
    fi

    PS1="!\! \A ${USER_INFO}${HOST_INFO}${HOST_SEPARATOR}${RESET}${LOCATION} \$ "
}

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

PROMPT_COMMAND=build-prompt
PATH="~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/heroku/bin:$PATH"

TEXTMATE=$(which mate 2> /dev/null)
if [[ $TEXTMATE ]]; then
    VISUAL="${TEXTMATE} -w"
    EDITOR="${TEXTMATE} -w"
    git config --global core.editor "$VISUAL"
fi

alias less='less -r'
alias ls='ls -G'
alias root='cd $(git rev-parse --show-toplevel)'

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi
