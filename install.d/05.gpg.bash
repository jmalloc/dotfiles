mkdir -p "$HOME/.gnupg"

if [ ! -e "$HOME/.gnupg/privkey.pem" ]; then
    echo "--- fetching GPG key from 1Password"
    op get document --account=my "GPG Private Key" > "$HOME/.gnupg/privkey.pem"
    chmod 600 "$HOME/.gnupg/privkey.pem"
    gpg --import "$HOME/.gnupg/privkey.pem"
fi

if [ ! -e "$HOME/.gnupg/pubkey.pem" ]; then
    echo "--- fetching public GPG key from 1Password"
    op get document --account=my "GPG Public Key" > "$HOME/.gnupg/pubkey.pem"
    gpg --import "$HOME/.gnupg/pubkey.pem"
fi
