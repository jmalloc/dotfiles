# This file contains custom p10k prompt segments.
# Their display location is configured in .p10k.zsh.

function prompt_docker() {
    local host="$(printenv DOCKER_HOST)"

    if [ -z "$host" ]; then
        return
    fi

    if [[ "$host" == "unix:///var/run/docker.sock" ]]; then
        return
    fi

    p10k segment -b 1 -f 7 -t "$host"
}
