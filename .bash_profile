for filename in ~/dotfiles/lib/*.bash; do
    source $filename
done

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
