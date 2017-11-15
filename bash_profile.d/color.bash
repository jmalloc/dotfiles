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

color-maroon() {
    colorize 1 "$@"
}

color-red() {
    colorize 9 "$@"
}

color-green() {
    colorize 22 "$@"
}

color-lime() {
    colorize 118 "$@"
}

color-gold() {
    colorize 94 "$@"
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

color-dark-blue() {
    colorize 18 "$@"
}

color-magenta() {
    colorize 56 "$@"
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
