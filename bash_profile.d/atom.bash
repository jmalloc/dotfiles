ICLOUD_DRIVE_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs"

if type -t atom > /dev/null; then
    alias e='atom .'

    if [[ -d "$ICLOUD_DRIVE_PATH" && ! -L "$HOME/.atom" ]]; then
        if [ -e "$HOME/.atom" ]; then
            rm -rf "$HOME/.atom"
        fi

        ln -s "$ICLOUD_DRIVE_PATH/atom" "$HOME/.atom"
    fi
fi
