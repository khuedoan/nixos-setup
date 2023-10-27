.POSIX:
.PHONY: default build test update

config ?= main

default: build

build:
	# TODO find a way to generate hardware configuration and avoid impure
	sudo nixos-rebuild \
		--impure \
		--flake '.#${config}' \
		switch

test:
	nixos-rebuild \
		--impure \
		--flake '.#testvm' \
		build-vm
	./result/bin/run-nixos-vm

update:
	nix flake update
