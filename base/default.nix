{ lib, pkgs, platform, ... }:

{
  imports = [
    ./${platform.parsed.kernel.name}.nix
  ];

  options.primaryUser = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "Local account username for this host.";
    };

    fullName = lib.mkOption {
      type = lib.types.str;
      default = "Khue Doan";
      description = "Display name for the primary user.";
    };

  };

  config = {
    environment.systemPackages = with pkgs; [
      curl
      git
      tmux
      tree
      unzip
      watch
    ];

    programs = {
      zsh.enable = true;
      direnv = {
        enable = true;
        silent = true;
      };
    };

    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      optimise.automatic = true;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
