mkdir -p "$HOME/.gnupg"

if [ ! -e "$HOME/.gnupg/privkey.pem" ]; then
    echo "--- fetching GPG key from 1Password"
    op get document --account=${OP_ACCOUNT} "GPG Private Key" > "$HOME/.gnupg/privkey.pem"
    chmod 600 "$HOME/.gnupg/privkey.pem"
    gpg --import "$HOME/.gnupg/privkey.pem"
    git config --global user.signingkey "$(op get item --account=${OP_ACCOUNT} "GPG Private Key" | jq --raw-output '.details.sections[].fields[]? | select(.t == "ID") | .v')"
fi

if [ ! -e "$HOME/.gnupg/pubkey.pem" ]; then
    echo "--- fetching public GPG key from 1Password"
    op get document --account=${OP_ACCOUNT} "GPG Public Key" > "$HOME/.gnupg/pubkey.pem"
    gpg --import "$HOME/.gnupg/pubkey.pem"
fi

echo "default-cache-ttl 28800" >> "$HOME/.gnupg/gpg-agent.conf"
echo "pinentry-program /usr/local/bin/pinentry-mac" >> "$HOME/.gnupg/gpg-agent.conf"
