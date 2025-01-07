SERIAL ?= $(shell bin/mac-serial)

.PHONY: try
switch:
	nix run nix-darwin -- switch --flake .#$(SERIAL)

.PHONY: try
build:
	nix run nix-darwin -- build --flake .#$(SERIAL)
