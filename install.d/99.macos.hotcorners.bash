# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Modifier 1048576 = command key

defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

defaults write com.apple.dock wvous-tr-corner -int 5 # start screen saver
defaults write com.apple.dock wvous-tr-modifier -int 1048576 # cmd key
defaults write com.apple.dock wvous-br-corner -int 6 # disable screen saver
defaults write com.apple.dock wvous-br-modifier -int 1048576 # cmd key
