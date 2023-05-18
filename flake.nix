{
  description = "NixOS";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
