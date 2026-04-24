{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, darwin, disko, nixos-hardware, home-manager, ... }:
  let
    baseModules = [
      ./base
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
        system = "x86_64-linux";
        specialArgs = {
          platform = nixpkgs.lib.systems.elaborate "x86_64-linux";
        };
        modules = baseModules ++ [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          ./hosts/ryzentower.nix
        ];
      };
      thinkpadz13 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          platform = nixpkgs.lib.systems.elaborate "x86_64-linux";
        };
        modules = baseModules ++ [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.lenovo-thinkpad-z13-gen1
          ./hosts/thinkpadz13.nix
        ];
      };
      codeserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          platform = nixpkgs.lib.systems.elaborate "x86_64-linux";
        };
        modules = baseModules ++ [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          ./hosts/codeserver.nix
        ];
      };
    };

    darwinConfigurations = {
      "MacBookPro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          platform = nixpkgs.lib.systems.elaborate "aarch64-darwin";
        };
        modules = baseModules ++ [
          home-manager.darwinModules.home-manager
          ./hosts/MacBookPro.nix
        ];
      };
      "AS-GXL19NXYYQ" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          platform = nixpkgs.lib.systems.elaborate "aarch64-darwin";
        };
        modules = baseModules ++ [
          home-manager.darwinModules.home-manager
          ./hosts/AS-GXL19NXYYQ.nix
        ];
      };
      macos-test = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          platform = nixpkgs.lib.systems.elaborate "aarch64-darwin";
        };
        modules = baseModules ++ [
          home-manager.darwinModules.home-manager
          ./hosts/macos-test.nix
        ];
      };
    };
  };
}
