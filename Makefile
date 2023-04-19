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

.PHONY: build
build: ~/.git
	sudo nixos-rebuild --flake . switch
