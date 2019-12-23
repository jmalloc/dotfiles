mkdir -p "$HOME/.ssh"
PRIVKEY="$HOME/.ssh/id_rsa"
PUBKEY="$HOME/.ssh/id_rsa.pub"

if [ ! -e "$PRIVKEY" ]; then
    echo "Fetching private SSH key from 1Password..."
    op get document --account=${OP_ACCOUNT} "SSH Private Key" > "$PRIVKEY.tmp"
    chmod 600 "$PRIVKEY.tmp"
    mv "$PRIVKEY.tmp" "$PRIVKEY"

    echo "Adding SSH passphrase to keychain..."
    cat "$PRIVKEY" | DISPLAY= SSH_ASKPASS="$DOTFILES_PATH/bin/passphrase.bash" ssh-add -K
else
    echo "Private SSH key already exists."
fi

if [ "$PUBKEY" -ot "$PRIVKEY" ]; then
    echo "Generating public SSH key from private key..."
    ssh-keygen -P "$($DOTFILES_PATH/bin/passphrase.bash)" -yf "$PRIVKEY" > "$PUBKEY.tmp"
    mv "$PUBKEY.tmp" "$PUBKEY"
else
    echo "Public SSH key is already up-to-date."
fi

pushd "$DOTFILES_PATH" > /dev/null
if git remote get-url origin | grep "https://" > /dev/null; then
    echo "Switching dotfiles repo use SSH..."
    git remote set-url origin "$(git config --get remote.origin.url | sed 's/https:\/\/github.com\//git@github.com:/')"
else
    echo "dotfiles repo already uses SSH."
fi
popd > /dev/null
