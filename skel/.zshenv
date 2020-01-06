if [[ $SHLVL = 1 ]]; then
    for FILE in "$HOME/.dotfiles/public/zshenv.d/"*.zsh; do
        source "$FILE"
    done

    for FILE in "$HOME/.dotfiles/private/zshenv.d/"*.zsh; do
        source "$FILE"
    done
fi
