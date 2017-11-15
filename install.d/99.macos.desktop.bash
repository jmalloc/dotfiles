# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

plist-set-or-add() {
    local name="$1"
    local type="$2"
    local value="$3"
    local file="$4"
    if /usr/libexec/PlistBuddy -c "Print $name" "$file" 2>&1 > /dev/null; then
        /usr/libexec/PlistBuddy -c "Set $name $value" "$file"
    else
        /usr/libexec/PlistBuddy -c "Add $name $type $value" "$file"
    fi
}

plist-set-or-add ":DesktopViewSettings:IconViewSettings:showItemInfo"      bool    true "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":FK_StandardViewSettings:IconViewSettings:showItemInfo"  bool    true "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":StandardViewSettings:IconViewSettings:showItemInfo"     bool    true "$HOME/Library/Preferences/com.apple.finder.plist"

plist-set-or-add ":DesktopViewSettings:IconViewSettings:labelOnBottom"     bool    false "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":FK_StandardViewSettings:IconViewSettings:labelOnBottom" bool    false "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":StandardViewSettings:IconViewSettings:labelOnBottom"    bool    false "$HOME/Library/Preferences/com.apple.finder.plist"

plist-set-or-add ":DesktopViewSettings:IconViewSettings:arrangeBy"         string  name "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":FK_StandardViewSettings:IconViewSettings:arrangeBy"     string  name "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":StandardViewSettings:IconViewSettings:arrangeBy"        string  name "$HOME/Library/Preferences/com.apple.finder.plist"

plist-set-or-add ":DesktopViewSettings:IconViewSettings:gridSpacing"       integer 80   "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":FK_StandardViewSettings:IconViewSettings:gridSpacing"   integer 80   "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":StandardViewSettings:IconViewSettings:gridSpacing"      integer 80   "$HOME/Library/Preferences/com.apple.finder.plist"

plist-set-or-add ":DesktopViewSettings:IconViewSettings:iconSize"          integer 48   "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":FK_StandardViewSettings:IconViewSettings:iconSize"      integer 48   "$HOME/Library/Preferences/com.apple.finder.plist"
plist-set-or-add ":StandardViewSettings:IconViewSettings:iconSize"         integer 48   "$HOME/Library/Preferences/com.apple.finder.plist"
