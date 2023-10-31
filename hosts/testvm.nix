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

  users.users.khuedoan = {
    password = "testvm";
  };
  services.getty.autologinUser = "khuedoan";
}
