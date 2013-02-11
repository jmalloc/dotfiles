TEXTMATE=$(which mate)

if [[ $TEXTMATE ]]; then
    VISUAL="${TEXTMATE} -w"
    EDITOR="${TEXTMATE} -w"
    git config --global core.editor "$VISUAL"
fi
