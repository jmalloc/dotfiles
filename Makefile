SERIAL ?= $(shell bin/mac-serial)

.PHONY: try
switch:
	nix flake update
	nix run nix-darwin -- switch --flake .#$(SERIAL)

.PHONY: try
build:
	nix flake update
	nix run nix-darwin -- build --flake .#$(SERIAL)
