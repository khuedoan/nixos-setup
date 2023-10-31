.POSIX:
.PHONY: default build test diff update

default: build

build:
	# TODO find a way to generate hardware configuration and avoid impure
	sudo nixos-rebuild \
		--impure \
		--flake '.#${host}' \
		switch

test:
	nixos-rebuild \
		--impure \
		--flake '.#testvm' \
		build-vm
	./result/bin/run-nixos-vm

diff:
	nixos-rebuild \
		--impure \
		--flake '.#${host}' \
		build
	nix store diff-closures \
		--allow-symlinked-store \
		/nix/var/nix/profiles/system ./result

update:
	nix flake update
