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
nix-shell -p git gnumake neovim disko
git clone https://github.com/khuedoan/nixos-setup
cd nixos-setup
# Remember to replace the placeholders
make install host=HOSTNAME disk=/dev/DISK
```

### Install on Apple Silicon MacBook Pro

The `macbookpro` host uses [nixos-apple-silicon](https://github.com/nix-community/nixos-apple-silicon)
for Apple Silicon support. Partitioning is managed by the Asahi installer
(shared with macOS), not disko, so the installation process differs from x86 hosts.

1. In macOS, run the Asahi installer to set up a UEFI boot environment:

```sh
curl https://alx.sh | sh
```

Choose "Resize an existing partition" to make room (at least 20GB), then
"UEFI environment only". Name it NixOS. Follow the prompts to set permissive
security and reboot.

2. Download the latest installer ISO from the
[nixos-apple-silicon releases](https://github.com/nix-community/nixos-apple-silicon/releases)
page and write it to a USB drive:

```sh
sudo dd bs=4M if=/path/to/nixos-apple-silicon.iso of=/dev/sdX conv=fsync oflag=direct status=progress
```

3. Shut down the Mac, insert the USB drive, and power on. U-Boot should boot
from USB automatically. If it boots the internal disk instead, hit a key to
stop autoboot, run `bootmenu`, and select the `usb 0` entry.

4. Partition and format the free space:

```sh
sudo -i
sgdisk /dev/nvme0n1 -n 0:0 -s
# Check the partition table to identify the new partition number (type 8300)
sgdisk /dev/nvme0n1 -p
mkfs.ext4 -L nixos /dev/nvme0n1pN  # replace N with actual partition number
```

5. Mount the partitions:

```sh
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-partuuid/$(cat /proc/device-tree/chosen/asahi,efi-system-partition) /mnt/boot
```

6. Connect to Wi-Fi and install:

```sh
iwctl station wlan0 connect YOUR_SSID
systemctl restart systemd-timesyncd
nix-shell -p git gnumake
git clone https://github.com/khuedoan/nixos-setup
cd nixos-setup
nixos-install --flake '.#macbookpro' --impure
```

7. After rebooting into the new system, update the `/boot` PARTUUID in
`hosts/macbookpro/default.nix` with the actual value from step 5 and rebuild:

```sh
make build host=macbookpro flags=--impure
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
