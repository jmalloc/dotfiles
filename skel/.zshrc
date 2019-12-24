setopt clobber # allow output redirection to clobber existing files

for FILE in "$HOME/.dotfiles/zshrc.d/"*; do
    source "$FILE"
done
