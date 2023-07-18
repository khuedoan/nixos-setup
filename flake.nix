{
  description = "NixOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ./home/khuedoan.nix
      ];
    };
    # TODO clean up tests
    nixosConfigurations.test = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
        {
           users.extraUsers.vm = {
             group = "wheel";
             isNormalUser = true;
             password = "testvm";
           };
           security.sudo = {
             enable = true;
             wheelNeedsPassword = false;
           };
        }
        home-manager.nixosModules.home-manager
        ./home/khuedoan.nix
      ];
    };
  };
}
