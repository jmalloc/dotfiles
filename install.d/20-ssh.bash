mkdir -p "$HOME/.ssh"

PRIVKEY="$HOME/.ssh/id_rsa"
PUBKEY="$HOME/.ssh/id_rsa.pub"

if [ ! -e "$PRIVKEY" ]; then
    echo "Fetching private SSH key from 1Password..."
    op get document --account="$OP_ACCOUNT" "$OP_ITEM_SSHKEY" > "$PRIVKEY.tmp"
    chmod 600 "$PRIVKEY.tmp"
    mv "$PRIVKEY.tmp" "$PRIVKEY"
fi

echo "Adding SSH passphrase to keychain..."
cat "$PRIVKEY" | DISPLAY= SSH_ASKPASS="$DOTFILES_PATH_PUBLIC/bin/passphrase.bash" ssh-add -K

if [ "$PUBKEY" -ot "$PRIVKEY" ]; then
    echo "Generating public SSH key from private key..."
    ssh-keygen -P "$($DOTFILES_PATH_PUBLIC/bin/passphrase.bash)" -yf "$PRIVKEY" > "$PUBKEY.tmp"
    mv "$PUBKEY.tmp" "$PUBKEY"
fi

pushd "$DOTFILES_PATH_PUBLIC" > /dev/null
if git remote get-url origin | grep "https://" > /dev/null; then
    echo "Switching dotfiles repo use SSH..."
    git remote set-url origin "git@github.com:$DOTFILES_REPO_PUBLIC.git"
fi
popd > /dev/null
