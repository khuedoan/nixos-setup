{
  description = "NixOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, nixos-hardware, home-manager }: {
    nixosConfigurations = {
      ryzentower = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          home-manager.nixosModules.home-manager
          ./users/khuedoan.nix
          ./hosts/ryzentower
        ];
      };

      thinkpadz13 = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-z13-gen1
          home-manager.nixosModules.home-manager
          ./users/khuedoan.nix
          ./hosts/thinkpadz13
        ];
      };

      testvm = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          home-manager.nixosModules.home-manager
          ./users/khuedoan.nix
          ./hosts/testvm
        ];
      };
    };
  };
}
