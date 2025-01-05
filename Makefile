.PHONY: nix
nix:
	nix run nix-darwin -- switch --flake ./nix\#common
