{
  description = "NixOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, nixos-hardware, home-manager }: {
    nixosConfigurations = {
      ryzentower = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          ./graphical.nix
          home-manager.nixosModules.home-manager
          ./users/khuedoan
          ./hosts/ryzentower
        ];
      };
      thinkpadz13 = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-z13-gen1
          ./graphical.nix
          home-manager.nixosModules.home-manager
          ./users/khuedoan
          ./hosts/thinkpadz13
        ];
      };
      codeserver = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          home-manager.nixosModules.home-manager
          ./users/khuedoan
          ./hosts/codeserver
        ];
      };
    };
  };
}
