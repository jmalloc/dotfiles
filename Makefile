SERIAL ?= $(shell bin/mac-serial)

.PHONY: install
install: flake-switch

.PHONY: flake-switch
flake-switch:
	sudo mkdir -p /tmp/nix-home
	[ -f /tmp/nix-home/.cache/nix/tarball-cache/HEAD ] || sudo rm -rf /tmp/nix-home/.cache/nix/tarball-cache
	HOME=/tmp/nix-home sudo nix run nix-darwin -- switch --flake .#$(SERIAL)

.PHONY: flake-update
flake-update:
	nix flake update
