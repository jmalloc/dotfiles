pushd "$DOTFILES_PATH" > /dev/null
git remote set-url origin "$(git config --get remote.origin.url | sed 's/https:\/\/github.com\//git@github.com:/')"
popd > /dev/null
