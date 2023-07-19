.POSIX:

.PHONY: default
default: build

~/.ssh/id_ed25519:
	ssh-keygen -t ed25519 -f "$@"

~/.git: ~/.ssh/id_ed25519
	cd ~ \
		&& git init \
		&& git config status.showUntrackedFiles no \
		&& git remote add origin https://github.com/khuedoan/dotfiles \
		&& git pull origin master \
		&& git remote set-url origin git@github.com:khuedoan/dotfiles

# TODO clean this up
~/Pictures/Wallpapers/LostInMindNord.jpg:
	curl \
		https://user-images.githubusercontent.com/27996771/129466074-64c92948-96b0-4673-be33-75ee26b82a6c.jpg \
		--output ${@} \
		--create-dirs

.PHONY: build
build: ~/.git ~/Pictures/Wallpapers/LostInMindNord.jpg
	# TODO find a way to generate hardware configuration and avoid impure
	sudo nixos-rebuild \
		--impure \
		--flake '.#main' \
		switch

.PHONY: test
test:
	nixos-rebuild \
		--impure \
		--flake '.#testvm' \
		build-vm
	./result/bin/run-nixos-vm

.PHONY: update
update:
	nix flake update
