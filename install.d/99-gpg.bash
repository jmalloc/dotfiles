echo "Fetching private GPG key from 1Password..."

gpg --batch --import <(op get document --account="$OP_ACCOUNT" "$OP_ITEM_GPGKEY")

echo "default-cache-ttl 28800" > "$HOME/.gnupg/gpg-agent.conf"
echo "pinentry-program $(which pinentry-mac)" >> "$HOME/.gnupg/gpg-agent.conf"
gpgconf --kill gpg-agent
