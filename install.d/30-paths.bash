echo "Configuring shell paths..."

TMPFILE=$(mktemp)
echo "$(go env GOPATH)/bin" > "$TMPFILE"
sudo mv "$TMPFILE" /etc/paths.d/golang
