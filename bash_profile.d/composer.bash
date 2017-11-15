if type -t composer > /dev/null; then
    if [ -z "$GITHUB_COM_TOKEN" ]; then
        echo "Warning: GITHUB_COM_TOKEN is not set."
    else
          composer config --global -- github-oauth.github.com "$GITHUB_COM_TOKEN"
    fi

    if [[ ! -z "$GITHUB_CWX_DOMAIN" && ! -z "$GITHUB_CWX_DOMAIN" ]]; then
        composer config --global github-domains github.com "$GITHUB_CWX_DOMAIN"
        composer config --global -- "github-oauth.${GITHUB_CWX_DOMAIN}" "$GITHUB_CWX_TOKEN"
    fi
fi
