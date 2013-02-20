function colorize {
    echo -n $(tput setaf $1)
    shift
    echo -n "$@"
}

function color-red {
    colorize 1 "$@"
}

function color-green {
    colorize 70 "$@"
}

function color-yellow {
    colorize 94 "$@"
}

function color-blue {
    colorize 26 "$@"
}

function color-magenta {
    colorize 56 "$@"
}

function color-cyan {
    colorize 45 "$@"
}

function color-white {
    colorize 7 "$@"
}

function color-grey {
    colorize 8 "$@"
}

function color-dark-grey {
    colorize 234 "$@"
}

function color-reset {
    echo -n $(tput sgr0)
}
