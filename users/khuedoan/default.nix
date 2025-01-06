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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN5ue4np7cF34f6dwqH1262fPjkowHQ8irfjVC156PCG"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      aria
      bat
      btop
      cargo
      delta
      fd
      ffmpeg
      foot
      fzf
      gh
      go
      jq
      k9s
      kubectl
      kubernetes-helm
      kustomize
      nodePackages.npm
      nodePackages.yarn
      nodejs
      ripgrep
      yt-dlp
      zoxide

      (pass-nodmenu.withExtensions (ext: with ext; [
        pass-import
        pass-otp
      ]))

      # Language servers
      gopls
      lua-language-server
      nil
      nodePackages.typescript-language-server
      pyright
      rust-analyzer
      terraform-ls

      # GUI
      blender
      brave
      gnome-sound-recorder
      neovide
      obs-studio
      onlyoffice-bin
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.khuedoan = {
      home = {
        stateVersion = "23.05";
        activation = {
          # TODO optimize this?
          dotfiles = ''
            set -eu

            [ -d ~/.git ] \
              || ${pkgs.git}/bin/git init \
              && ${pkgs.git}/bin/git config status.showUntrackedFiles no \
              && ${pkgs.git}/bin/git remote add origin https://github.com/khuedoan/dotfiles \
              && (until ${pkgs.iputils}/bin/ping -c 1 github.com; do sleep 1; done) \
              && ${pkgs.git}/bin/git pull origin master \
              && ${pkgs.git}/bin/git branch --set-upstream-to=origin/master master

            [ -d ~/Pictures/Wallpapers ] \
              || ${pkgs.curl}/bin/curl \
                --location \
                https://github.com/user-attachments/assets/b63195d0-7fe3-4ab5-95c7-20127123836c \
                --output ~/Pictures/Wallpapers/astronaut-jellyfish.jpg \
                --create-dirs

            [ -d ~/.ssh ] \
              || ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
          '';
        };
      };
      services = {
        easyeffects.enable = true;
      };
      home.pointerCursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      gtk = {
        enable = true;
        theme = {
          package = pkgs.arc-theme;
          name = "Arc-Dark";
        };
        iconTheme = {
          package = pkgs.arc-icon-theme;
          name = "Arc";
        };
      };
    };
  };
}
