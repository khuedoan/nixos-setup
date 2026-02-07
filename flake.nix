{
  description = "NixOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, disko, nixos-hardware, home-manager }:
  let
    baseModules = [
      disko.nixosModules.disko
      ./configuration.nix
      home-manager.nixosModules.home-manager
      ./users/khuedoan
      {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit (prev.stdenv.hostPlatform) system;
              config = prev.config;
            };
          })
        ];
      }
    ];
  in {
    nixosConfigurations = {
      ryzentower = nixpkgs.lib.nixosSystem {
        modules = baseModules ++ [
          ./graphical.nix
          ./hosts/ryzentower
        ];
      };
      thinkpadz13 = nixpkgs.lib.nixosSystem {
        modules = baseModules ++ [
          nixos-hardware.nixosModules.lenovo-thinkpad-z13-gen1
          ./graphical.nix
          ./hosts/thinkpadz13
        ];
      };
      codeserver = nixpkgs.lib.nixosSystem {
        modules = baseModules ++ [
          ./hosts/codeserver
        ];
      };
    };
  };
}
