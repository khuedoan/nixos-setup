.POSIX:
.PHONY: default build switch diff update install clean

default: diff switch

build:
	./scripts/rebuild.py build --flake '.#$(host)'

diff: build
	nix store diff-closures \
		--allow-symlinked-store \
		/nix/var/nix/profiles/system ./result

switch:
	sudo ./scripts/rebuild.py switch --flake '.#$(host)'

update:
	nix flake update

install:
	# This consumes significant memory on the live USB because dependencies are
	# downloaded to tmpfs. The configuration must be small, or the machine must
	# have a lot of RAM.
	sudo disko-install \
		--write-efi-boot-entries \
		--flake '.#$(host)' \
		--disk main '$(disk)'

clean:
	nix-collect-garbage --delete-old --log-format bar
