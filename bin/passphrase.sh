# Used during installation to fetch SSH Passphrase from 1Password.
# This is implemented as a standalone executable so it can be used with SSH_ASKPASS.
op get item --account=${OP_ACCOUNT} "SSH Private Key" | jq --raw-output '.details.sections[].fields[]? | select(.t == "Passphrase") | .v'
