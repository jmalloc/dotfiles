if [[ "$(uname -p)" == "arm" ]]; then
     if [[ ! -f /Library/Apple/usr/share/rosetta/rosetta ]]; then
         echo "Installing Rosetta..."
         sudo softwareupdate --install-rosetta
     fi
 fi
