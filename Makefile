.PHONY: try
switch:
	nix run nix-darwin -- switch --flake .#$$(sysctl -n hw.model | egrep -io '^[a-z]+')

.PHONY: try
build:
	nix run nix-darwin -- build --flake .#$$(sysctl -n hw.model | egrep -io '^[a-z]+')
