# Used during installation to fetch SSH Passphrase from 1Password
op get item --account=my "SSH Private Key" | jq --raw-output '.details.sections[].fields[]? | select(.t == "Passphrase") | .v'
