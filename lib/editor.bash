# Sublime Text 3 ...
if [ -d "/Applications/Sublime Text.app/Contents/SharedSupport/bin" ]; then
	PATH="$PATH:/Applications/Sublime Text.app/Contents/SharedSupport/bin"
# Sublime Text 2
elif [ -d "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin" ]; then
	PATH="$PATH:/Applications/Sublime Text 2.app/Contents/SharedSupport/bin"
fi

SUBLIME=$(which subl 2>/dev/null)
TEXTMATE=$(which mate 2>/dev/null)

if [[ $SUBLIME ]]; then
	VISUAL="subl -w"
elif [[ $TEXTMATE ]]; then
    VISUAL="mate -w"
else
	VISUAL=vim
fi

EDITOR="$VISUAL"
git config --global core.editor "$VISUAL"
