SERIAL ?= $(shell bin/mac-serial)

.PHONY: install
install: update switch

.PHONY: update
update:
	nix flake update

.PHONY: switch
switch:
	sudo mkdir -p /tmp/nix-home
	[ -f /tmp/nix-home/.cache/nix/tarball-cache/HEAD ] || sudo rm -rf /tmp/nix-home/.cache/nix/tarball-cache
	HOME=/tmp/nix-home sudo nix run nix-darwin -- switch --flake .#$(SERIAL)

.PHONY: build
build:
	nix run nix-darwin -- build --flake .#$(SERIAL)
