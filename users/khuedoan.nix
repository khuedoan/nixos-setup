{ pkgs, ... }:

{
  users.users.khuedoan = {
    isNormalUser = true;
    description = "Khue Doan";
    extraGroups = [
      "docker"
      "libvirtd"
      "networkmanager"
      "video"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      aria
      bat
      brave
      btop
      cargo
      fd
      ffmpeg
      firefox-wayland
      foot
      fzf
      gh
      gnome.gnome-sound-recorder
      go
      jq
      k9s
      kubectl
      kubernetes-helm
      kustomize
      nodePackages.npm
      nodePackages.yarn
      nodejs
      obs-studio
      ripgrep
      zoxide

      # Language servers
      gopls
      lua-language-server
      nodePackages.typescript-language-server
      rust-analyzer
      terraform-ls

      (pass.withExtensions (ext: with ext; [
        pass-import
        pass-otp
      ]))
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.khuedoan = {
      home.stateVersion = "23.05";
      home.activation = {
        # TODO optimize this?
        dotfiles = ''
          set -eu

          [ -d ~/.git ] \
            || ${pkgs.git}/bin/git init \
            && ${pkgs.git}/bin/git config status.showUntrackedFiles no \
            && ${pkgs.git}/bin/git remote add origin https://github.com/khuedoan/dotfiles \
            && ${pkgs.git}/bin/git pull origin master \
            && ${pkgs.git}/bin/git branch --set-upstream-to=origin/master master

          [ -d ~/Pictures/Wallpapers ] \
            || ${pkgs.curl}/bin/curl \
              https://user-images.githubusercontent.com/27996771/129466074-64c92948-96b0-4673-be33-75ee26b82a6c.jpg \
              --output ~/Pictures/Wallpapers/LostInMindNord.jpg \
              --create-dirs

          [ -d ~/.ssh ] \
            || ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
        '';
      };
      services = {
        easyeffects.enable = true;
      };
      home.pointerCursor = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };
    };
  };
}
