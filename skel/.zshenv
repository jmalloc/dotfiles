if [[ $SHLVL = 1 ]]; then
    for FILE in "$HOME/.dotfiles/zshenv.d/"*; do
        source "$FILE"
    done
fi
