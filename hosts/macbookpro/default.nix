{ lib, ... }:

{
  nixpkgs.hostPlatform = "aarch64-linux";

  networking.hostName = "macbookpro";

  # Override shared x86 disko layout, Asahi installer manages partitioning
  disko.devices = lib.mkForce {};

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = lib.mkForce false;
    };
    binfmt.emulatedSystems = lib.mkForce [];
  };

  # Filesystem mounts (update UUIDs after install)
  # Root partition labeled during mkfs.ext4 -L nixos
  # Boot partition PARTUUID from: cat /proc/device-tree/chosen/asahi,efi-system-partition
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = lib.mkDefault "/dev/disk/by-partuuid/PLACEHOLDER";
      fsType = "vfat";
    };
  };

  # Peripheral firmware from EFI partition (requires --impure flag when building)
  hardware.asahi.peripheralFirmwareDirectory = /boot/asahi;

  # Binary cache for Asahi kernel
  nix.settings = {
    extra-substituters = [
      "https://nixos-apple-silicon.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };

  home-manager.users.khuedoan.home.file = {
    ".config/sway/config.d/hardware".text = ''
      output "eDP-1" {
        scale 2
      }

      bindswitch --reload --locked lid:on output eDP-1 disable
      bindswitch --reload --locked lid:off output eDP-1 enable
    '';
  };
}
