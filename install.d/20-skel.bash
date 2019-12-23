echo "Symlinking home directory skeleton..."

SKEL="$DOTFILES_PATH/skel"

for TARGET in $(find "$SKEL" -type f); do
    NAME="${TARGET#$SKEL/}"
    LINK="$HOME/$NAME"

    if [ -e "$LINK" ]; then
        echo "$NAME already exists."
    else
        echo "Linking $NAME..."
        ln -s "$TARGET" "$LINK"
    fi
done

NAME="zshrc.d"
LINK="$HOME/.$NAME"
TARGET="$DOTFILES_PATH/$NAME"

if [ -e "$LINK" ]; then
    echo "$NAME already exists."
else
    echo "Linking $NAME..."
    ln -s "$TARGET" "$LINK"
fi
