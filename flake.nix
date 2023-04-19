{
  description = "NixOS";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.RyzenTower = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
