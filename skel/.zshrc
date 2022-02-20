for FILE in "$HOME/.dotfiles/public/zshrc.d/"*.zsh; do
    source "$FILE"
done

for FILE in "$HOME/.dotfiles/private/zshrc.d/"*.zsh; do
    source "$FILE"
done
