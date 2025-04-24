SERIAL ?= $(shell bin/mac-serial)

.PHONY: install
install: update switch

.PHONY: update
update:
	nix flake update

.PHONY: switch
switch:
	nix run nix-darwin -- switch --flake .#$(SERIAL)

.PHONY: build
build:
	nix run nix-darwin -- build --flake .#$(SERIAL)
