{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/qemu-vm.nix")
  ];

  networking = {
    hostName = "testvm";
  };

  virtualisation = {
    qemu.options = [
      "-device virtio-vga-gl"
      "-display gtk,gl=on"
    ];
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };

  users.users.khuedoan = {
    password = "testvm";
  };
  services.getty.autologinUser = "khuedoan";
}
