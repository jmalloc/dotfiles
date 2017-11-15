if type -t git > /dev/null; then
    alias g='git'

    if [ ! -z "$GITHUB_CWX_DOMAIN" ]; then
        git config --global --replace-all hub.host "$GITHUB_CWX_DOMAIN"
    fi
fi
