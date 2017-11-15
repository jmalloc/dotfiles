mkdir -p "$HOME/.bash_profile.d"
mkdir -p "$HOME/bin"

# Create symlinks from various dotfiles that need to be in particular locations
# to the files contained in the dotfiles repo.

for FILE in "$DOTFILES_PATH/dotfiles/".*; do
    NAME=$(basename $FILE)

    if [[ "." == $NAME || ".." == $NAME ]]; then
        # Skip special directories ...
        continue
    elif [ -L "$HOME/$NAME" ]; then
        if [[ "$(readlink "$HOME/$NAME")" != "$FILE" ]]; then
            rm -f "$HOME/$NAME"
            ln -s $FILE "$HOME/$NAME"
            echo "--- updated symlink $NAME to $FILE"
        fi
    elif [ -e "$HOME/$NAME" ]; then
        echo "--- not updating $NAME, it is not a symlink"
    else
        ln -s $FILE "$HOME/$NAME"
        echo "--- created symlink $NAME to $FILE"
    fi
done
