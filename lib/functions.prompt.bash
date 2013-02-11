PROMPT_COMMAND=build-prompt
DEFAULT_USERNAME=james

function build-prompt {
    local auth=''
    if [[ $USER != $DEFAULT_USERNAME ]]; then
        auth=$(color-yellow $USER)
    fi

    if [ $SSH_TTY ]; then
        auth="${auth}$(color-yellow "@\h")"
    fi

    if [ $(which git 2>/dev/null) ]; then
        local git=$(git-root)
        local location=$(color-blue "\w")

        if [ $git ]; then
            local path=''
            if [[ $(pwd) != $git ]]; then
                path=" $(pwd | cut -c$(expr 2 + ${#git})-)"
            fi

            local branch=$(git-branch)
            local rev=$(git-rev)
        
            if [[ $branch == "develop" ]]; then
                branch=$(color-white develop)
            elif [[ $branch == "master" ]]; then
                branch=$(color-red master)
            elif [[ $rev == "" ]]; then
                branch=$(color-yellow "<empty>")
            elif [[ $branch == "" ]]; then
                branch=$(color-red $rev)
            else
                branch=$(color-green $branch)
            fi

            location="$(color-magenta $(git-repo)) ${branch}$(color-blue "$path")"
        fi
    fi

    PS1=$(echo "$(color-dark-grey "!\! \A") $auth $location$(color-dark-grey :) $(color-reset)" | sed -E "s/[ ]+/ /g")
}
