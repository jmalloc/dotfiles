if [[ $(defaults read com.apple.terminal "Startup Window Settings") != "custom-theme" ]]; then
    echo "Installing custom terminal theme (this opens a new terminal window which can be safely closed)..."
    open "$DOTFILES_PATH/install.d/custom-theme.terminal"
    defaults write com.apple.terminal "Default Window Settings" -string "custom-theme"
    defaults write com.apple.terminal "Startup Window Settings" -string "custom-theme"
else
    echo "Custom terminal theme already installed."
fi
