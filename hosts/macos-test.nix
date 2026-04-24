{ config, lib, ... }:

{
  primaryUser.username = "runner";

  networking.hostName = "macos-test";

  # Linux builder is disabled in CI until bootstrap issues are fixed.
  nix.linux-builder.enable = lib.mkForce false;

  home-manager = {
    users.${config.primaryUser.username} = {
      home.stateVersion = "25.11";
      programs.home-manager.enable = true;
    };
  };
}
