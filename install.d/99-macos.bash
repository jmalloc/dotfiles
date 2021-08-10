echo "Applying macOS defaults..."

### DISPLAY ####################################################################

# Turn off font smoothing on retina displays
if system_profiler SPDisplaysDataType | grep 'retina' > /dev/null; then
  defaults -currentHost write NSGlobalDomain AppleFontSmoothing -int 0
fi

# Date formats
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d h:mm a"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict \
  1 -string "y-MM-dd" \
  2 -string "y-MM-dd" \
  3 -string "y-MM-dd" \
  4 -string "y-MM-dd"

# Disable janky animation when zooming windows (works intermittently)
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false


### KEYBOARD ###################################################################

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a short initial delay and fast repeat rate
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# Enable full keyboard access for all controls (tab through inputs, etc)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use function keys as actual function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Disable auto correct and other substitutions
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable auto correct and other substitutions in Message.app.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false


### MOUSE & TRACKPAD ###########################################################

# Enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Top-right hot corner + cmd turns on screen saver
defaults write com.apple.dock wvous-tr-corner -int 5 # start screen saver
defaults write com.apple.dock wvous-tr-modifier -int 1048576 # cmd key

# Bottom-right hot corner + cmd disables screen saver
defaults write com.apple.dock wvous-br-corner -int 6 # disable screen saver
defaults write com.apple.dock wvous-br-modifier -int 1048576 # cmd key


### SOUND ######################################################################

# Disable UI sound effects (e.g. when emptying the bin)
defaults write com.apple.systemsound com.apple.sound.uiaudio.enabled -int 0

# Enable volume change feedback beep
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 1

# Disable sound effects in Message.app.
defaults write com.apple.messageshelper.AlertsController PlaySoundsKey -int 0





### DESKTOP & FINDER ###########################################################

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# List directories above files
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Hide recent tags
defaults write com.apple.finder ShowRecentTags -bool false

# Show the path bar
defaults write com.apple.finder ShowPathbar -bool true

# Hide the status bar
defaults write com.apple.finder ShowStatusBar -bool false

# Use the home directory as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Search the current directory by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Turn off automatic Desktop icons
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Allow Finder to be quit normally
defaults write com.apple.finder QuitMenuItem -bool true


### DOCK, SPOTLIGHT, ETC #######################################################

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# "Disable" the Dock by using a very long autohide delay
defaults write com.apple.dock autohide-delay -float 1000

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Set the icon size of Dock items to 28->64 pixels with magnification
defaults write com.apple.dock tilesize -int 28
defaults write com.apple.dock largesize -int 64
defaults write com.apple.dock magnification -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don't display first-time Spotlight messages
defaults write com.apple.spotlight showedFTE 1
defaults write com.apple.spotlight showedLearnMore 1


### MAIL #######################################################################

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>`
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Disable send and reply animations in Mail.app
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true


### OTHER ######################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Automatic updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool true
sudo defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true

# Save screenshots to /tmp
defaults write com.apple.screencapture location -string "/tmp"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

killall \
  "Address Book" \
  "Calendar" \
  "ControlStrip" \
  "cfprefsd" \
  "Contacts" \
  "Dock" \
  "Finder" \
  "Calendar" \
  "Music" \
  "Mail" \
  "Safari" \
  "Spotlight" \
  "SystemUIServer"
