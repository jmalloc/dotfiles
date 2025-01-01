if [[ -d "$DOTFILES_PATH_PRIVATE" ]]; then
    echo "Pulling $DOTFILES_REPO_PRIVATE..."
    pushd "$DOTFILES_PATH_PRIVATE" > /dev/null
    git pull
    popd > /dev/null
else
    echo "Cloning $DOTFILES_REPO_PRIVATE..."
    git clone \
        --branch "$DOTFILES_BRANCH" \
        --single-branch "git@github.com:$DOTFILES_REPO_PRIVATE.git" \
        "$DOTFILES_PATH_PRIVATE"
fi
