# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use function keys as actual function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a key delay (initial) and repeat to the fastest settings available
# from the UI ...
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Ctrl + Alt + Cmd + W = Close All Tabs in Atom
# @ = command
# $ = shift
# ~ = alt/option
# ^ = control
defaults write com.github.atom NSUserKeyEquivalents -dict-add "Close All Tabs" -string "@~^w"
