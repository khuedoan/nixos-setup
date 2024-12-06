# NixOS Setup

Automatically install and configure NixOS.

## Usage

### Customize the configuration

Review all files and adjust the configurations to suit your needs. At a
minimum, you’ll need to change the following:

- Users:
    - Replace `khuedoan` with your username.
    - Replace my SSH public keys with yours.
    - Replace `khuedoan/dotfiles` with your dotfiles repository, or use `home-manager` to manage all dotfiles.
  
- Hosts:
    - Replace my hostnames with yours.
    - Adjust hardware configurations to match your system.

### Install with the NixOS Live CD

1. Download the latest NixOS live CD from [here](https://nixos.org/download).
2. Create a bootable USB drive:

```sh
sudo dd bs=4M if=/path/to/nixos.iso of=/dev/sda conv=fsync oflag=direct status=progress
```

3. Boot from the USB drive.
4. Install NixOS from the live CD:

```sh
nix-shell -p git gnumake neovim
git clone https://github.com/khuedoan/nixos-setup
cd nixos-setup
# Remember to replace the placeholders
make install host=HOSTNAME disk=/dev/DISK
```

### Apply changes

After installation, clone your repository again and apply changes to the
configuration by running:

```sh
make
```

### Update hardware configuration

If hardware changes occur, update the hardware configuration using the command
in the `install` target in `./Makefile`.

## Testing

To test updated configurations without applying them to a running machine, create a VM using:

```sh
make test
```
