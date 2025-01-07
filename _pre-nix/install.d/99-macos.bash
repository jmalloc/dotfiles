echo "Applying macOS defaults..."

### DISPLAY ####################################################################

# Turn off font smoothing on retina displays
if system_profiler SPDisplaysDataType | grep -i 'retina' > /dev/null; then
  defaults -currentHost write NSGlobalDomain AppleFontSmoothing -int 0
fi

### KEYBOARD ###################################################################

# Disable auto correct and other substitutions in Message.app.
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

### SOUND ######################################################################

# Disable sound effects in Message.app.
defaults write com.apple.messageshelper.AlertsController PlaySoundsKey -int 0


### MAIL #######################################################################

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>`
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Disable send and reply animations in Mail.app
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

### OTHER ######################################################################

# Make XCode use system's regular Git setup for pulling Swift package manager
# dependencies.

defaults write com.apple.dt.Xcode IDEPackageSupportUseBuiltinSCM YES

# Automatic updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool true
sudo defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true
