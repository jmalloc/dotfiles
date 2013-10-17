function update-dotfiles {
    local path=
    local name=

    echo 'Installing dotfiles ...'
    for path in $DOTFILES_REPO/dotfiles/.*; do
        name=$(basename $path)

        # Skip special directories ...
        if [[ "." == $name || ".." == $name ]]; then
            # skip ...
            true;
        elif [ -L "$HOME/$name" ]; then
            rm -f "$HOME/$name"
            ln -s $path "$HOME/$name"
            echo "  $(color-green)>>> $(color-dark-grey)Updated symlink $(color-grey)$name$(color-dark-grey) to $(color-grey)$path"
        elif [ -e "$HOME/$name" ]; then
            echo "  $(color-red)!!! $(color-dark-grey)Not updating $(color-grey)${name}$(color-dark-grey), it is not a symlink."
        else
            ln -s $path "$HOME/$name"
            echo "  $(color-green)>>> $(color-dark-grey)Created symlink $(color-grey)$name$(color-dark-grey) to $(color-grey)$path"
        fi
    done
}
