if [ ! -e "$HOME/bin/grit" ]; then
    pushd "$HOME/bin" > /dev/null
    curl -L "https://github.com/jmalloc/grit/releases/download/0.6.4/grit-darwin-amd64.tar.gz" | tar -x
    popd > /dev/null
fi

$HOME/bin/grit self-update
