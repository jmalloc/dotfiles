ESCAPE_COLOR_CODES=false

colorize() {
    if [[ $ESCAPE_COLOR_CODES == "true" ]]; then
        echo -n "\[$(tput setaf $1)\]"
    else
        echo -n $(tput setaf $1)
    fi
    shift
    echo -n "$@"
}

color-reset() {
    if [[ $ESCAPE_COLOR_CODES == "true" ]]; then
        echo -n "\[$(tput sgr0)\]"
    else
        echo -n $(tput sgr0)
    fi
}

color-red() {
    colorize 1 "$@"
}

color-green() {
    colorize 70 "$@"
}

color-gold() {
    colorize 136 "$@"
}

color-yellow() {
    colorize 220 "$@"
}

color-orange() {
    colorize 202 "$@"
}

color-blue() {
    colorize 26 "$@"
}

color-magenta() {
    colorize 56 "$@"
}

color-cyan() {
    colorize 45 "$@"
}

color-white() {
    colorize 7 "$@"
}

color-grey() {
    colorize 8 "$@"
}

color-dark-grey() {
    colorize 234 "$@"
}
