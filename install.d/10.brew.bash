pkgs="
awscli
bash-completion
colordiff
ghi
git
go
hub
jq
mas
node
php71
php71-intl
watch
wget
yarn
"

brew upgrade

for p in $pkgs; do
    if ! brew list $p 2>&1 > /dev/null; then
        echo "--- installing brew package: $p"
        brew install "$p"
    fi
done
