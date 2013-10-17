# Sublime Text 3 ...
if [ -d "/Applications/Sublime Text.app/Contents/SharedSupport/bin" ]; then
	PATH="$PATH:/Applications/Sublime Text.app/Contents/SharedSupport/bin"
fi

SUBLIME=$(which subl 2> /dev/null)

if [[ $SUBLIME ]]; then
	VISUAL="subl -w"
else
	VISUAL=vim
fi

EDITOR="$VISUAL"
git config --global core.editor "$VISUAL"
