# Extract the GitHub token from 1Password. The token I use from my workstation
# is stored in an item named  "GitHub", under a section titled "API Tokens",
# with the key "OSX".
if [ -z "$GITHUB_COM_TOKEN" ]; then
    echo "--- fetching GitHub API token from 1Password"
    export GITHUB_COM_TOKEN=$(op get item --account=my GitHub | jq --raw-output '.details.sections[] | select(.title == "API Tokens") | .fields[] | select(.t == "OSX") | .v')
fi

# Write GitHub.com Personal Access Token to a file included by .bash_profile.
f="$HOME/.bash_profile.d/github-token"
if ! grep "$GITHUB_COM_TOKEN" "$f" 2>&1 > /dev/null; then
    echo "--- generating $f"
    echo "export GITHUB_COM_TOKEN=$GITHUB_COM_TOKEN" > "$f"
    echo 'export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_COM_TOKEN' >> "$f"
    source "$f"
fi
