op get item --account=my "SSH Private Key" | jq --raw-output '.details.sections[].fields[]? | select(.t == "Passphrase") | .v'
