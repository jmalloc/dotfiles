eval "$(/opt/homebrew/bin/brew shellenv)"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# install an older version of a Homebrew formula
function brew-install-version () {
    FORMULA="$1"
    VERSION="$2"
    TAP="$3"

    if [[ -z "$FORMULA" || -z "$VERSION" ]]; then
        >&2 echo "Usage: $0 <formula> <version> [<tap>]"
        >&2 echo "Example: $0 kubernetes-cli 1.25"
        >&2 echo "Example: $0 telepresence-arm64 2.8.5 datawire/blackbird"

        return 1
    fi

    LOCAL_TAP="$USER/local-versions"

    if [[ -z "$TAP" ]]; then
        FULL_FORMULA="$FORMULA"
    else
        FULL_FORMULA="$TAP/$FORMULA"
    fi

    brew tap-new "$LOCAL_TAP" &>/dev/null || true
    brew extract --force --version="$VERSION" "$FULL_FORMULA" "$LOCAL_TAP"
    brew install "$LOCAL_TAP/$FORMULA@$VERSION"
    brew link --overwrite "$LOCAL_TAP/$FORMULA@$VERSION"
}
