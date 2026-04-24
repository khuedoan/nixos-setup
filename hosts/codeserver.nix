{ ... }:

{
  imports = [
    ../modules/cli
    ../modules/dotfiles
    ../modules/personal
  ];

  primaryUser.username = "khuedoan";

  nixpkgs = {
    hostPlatform = "x86_64-linux";
  };

  networking = {
    hostName = "codeserver";
  };
}
