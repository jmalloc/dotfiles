# Set the icon size of Dock items to 28->64 pixels with magnification
defaults write com.apple.dock tilesize -int 28
defaults write com.apple.dock largesize -int 64
defaults write com.apple.dock magnification -bool true

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
