pkgs="
atom
docker
google-chrome
"

for p in $pkgs; do
    if ! brew cask list $p 2>&1 > /dev/null; then
        echo "--- installing brew cask: $p"
        echo brew cask install "$p"
        brew cask install "$p"
    fi
done
