# Used during installation to fetch SSH Passphrase from 1Password.
# This is implemented as a standalone executable so it can be used with SSH_ASKPASS.
op get item --account="$OP_ACCOUNT" "$OP_ITEM_SSHKEY" | jq --raw-output '.details.sections[].fields[]? | select(.t == "Passphrase") | .v'
