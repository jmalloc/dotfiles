for filename in ~/dotfiles/.*; do
    if [ -f $filename ]; then
        cp -f $filename ~
    fi
done

for filename in ~/dotfiles/lib/*.bash; do
    source $filename
done

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

unset filename
