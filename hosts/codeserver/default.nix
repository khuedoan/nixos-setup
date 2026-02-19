{ pkgs, ... }:

{
  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };

  networking = {
    hostName = "codeserver";
  };
}
