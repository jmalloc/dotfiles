SERIAL ?= $(shell bin/mac-serial)

.PHONY: install
install: flake-switch

.PHONY: flake-switch
flake-switch:
	sudo mkdir -p /tmp/nix-home
	for d in tarball-cache tarball-cache-v2; do \
		[ -f /tmp/nix-home/.cache/nix/$$d/HEAD ] || \
			sudo rm -rf /tmp/nix-home/.cache/nix/$$d; \
	done
	HOME=/tmp/nix-home sudo nix run nix-darwin -- switch --flake .#$(SERIAL)

.PHONY: flake-update
flake-update:
	nix flake update
