SKEL="$DOTFILES_PATH/skel"

for TARGET in $(find "$SKEL" -type f); do
    NAME="${TARGET#$SKEL/}"
    LINK="$HOME/$NAME"

    if [ -L "$LINK" ]; then
        CURRENT_TARGET=$(readlink "$LINK")
        if [[ "$CURRENT_TARGET" == "$TARGET" ]]; then
            continue
        fi
        echo "Removing existing $NAME symlink to $CURRENT_TARGET..."
        rm -f "$LINK"
    elif [ -e "$LINK" ]; then
        echo "Removing existing $NAME file, with content as below..."
        echo
        cat "$LINK"
        echo
        rm -f "$LINK"
    fi

    echo "Creating $NAME symlink..."
    mkdir -p $(dirname "$LINK")
    ln -s "$TARGET" "$LINK"
done
