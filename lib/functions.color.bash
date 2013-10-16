ESCAPE_COLOR_CODES=false

function colorize {
    if [[ $ESCAPE_COLOR_CODES == "true" ]]; then
        echo -n "\[$(tput setaf $1)\]"
    else
        echo -n $(tput setaf $1)
    fi
    shift
    echo -n "$@"
}

function color-red {
    colorize 1 "$@"
}

function color-green {
    colorize 70 "$@"
}

function color-gold {
    colorize 136 "$@"
}

function color-yellow {
    colorize 220 "$@"
}

function color-orange {
    colorize 202 "$@"
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
    if [[ $ESCAPE_COLOR_CODES == "true" ]]; then
        echo -n "\[$(tput sgr0)\]"
    else
        echo -n $(tput sgr0)
    fi
}
