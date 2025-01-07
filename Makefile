HARDWARE_UUID ?= $(shell bin/hardware-uuid)

.PHONY: try
switch:
	nix run nix-darwin -- switch --flake .#$(HARDWARE_UUID)

.PHONY: try
build:
	nix run nix-darwin -- build --flake .#$(HARDWARE_UUID)
