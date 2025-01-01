if [[ "$(uname -p)" == "arm" ]]; then
     if [[ ! -f /Library/Apple/usr/share/rosetta/rosetta ]]; then
         echo "Installing Rosetta..."
         softwareupdate --install-rosetta --agree-to-license
     fi
 fi
