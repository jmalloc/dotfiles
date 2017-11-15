mkdir -p "$HOME/.ssh"

if [ ! -e "$HOME/.ssh/id_rsa" ]; then
    echo "--- fetching SSH key from 1Password"
    op get document --account=my "SSH Private Key" > "$HOME/.ssh/id_rsa"
    chmod 600 "$HOME/.ssh/id_rsa"

    echo "--- adding SSH passphrase to keychain"
    cat "$HOME/.ssh/id_rsa" | DISPLAY= SSH_ASKPASS="$DOTFILES_PATH/bin/passphrase.sh" ssh-add -K
fi

if [ ! -e "$HOME/.ssh/id_rsa.pub" ]; then
    echo "--- generating public SSH key from private key"
    ssh-keygen -P "$($DOTFILES_PATH/bin/passphrase.sh)" -yf "$HOME/.ssh/id_rsa" > "$HOME/.ssh/id_rsa.pub"
fi
