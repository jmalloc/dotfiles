# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Before are functiosn for custom p10k prompt segments.
# Their display location is configured in .p10k.zsh.

function prompt_docker() {
    local host="$(printenv DOCKER_HOST)"

    if [ -z "$host" ]; then
        return
    fi

    if [[ "$host" == "unix:///var/run/docker.sock" ]]; then
        return
    fi

    p10k segment -b 1 -f 11 -t "$host"
}

function prompt_gitwip() {
    if git log -n 1 --pretty=%B 2>/dev/null | grep WIP > /dev/null; then
        p10k segment -b 1 -f 11 -t "WORK IN PROGRESS"
    fi
}

function prompt_telepresence() {
    local container="$(printenv TELEPRESENCE_CONTAINER)"

    if [ -z "$container" ]; then
        return
    fi

    p10k segment -b 1 -f 11 -t "intercepting $container"
}
