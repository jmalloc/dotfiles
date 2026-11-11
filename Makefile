SERIAL ?= $(shell bin/mac-serial)

# "apm" must run after "flake-switch", so don't run prerequisites in parallel.
.NOTPARALLEL:

.PHONY: install
install: flake-switch apm

.PHONY: flake-switch
flake-switch:
	sudo mkdir -p /tmp/nix-home
	[ -f /tmp/nix-home/.cache/nix/tarball-cache/HEAD ] || sudo rm -rf /tmp/nix-home/.cache/nix/tarball-cache
	HOME=/tmp/nix-home sudo nix run nix-darwin -- switch --flake .#$(SERIAL)

.PHONY: flake-update
flake-update:
	nix flake update

.PHONY: apm
apm:
	apm install -g
