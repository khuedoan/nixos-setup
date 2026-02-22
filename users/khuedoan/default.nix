{ pkgs, ... }:

{
  users.users.khuedoan = {
    isNormalUser = true;
    description = "Khue Doan";
    extraGroups = [
      "docker"
      "libvirtd"
      "networkmanager"
      "tss"
      "video"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN5ue4np7cF34f6dwqH1262fPjkowHQ8irfjVC156PCG"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      aria2
      bat
      btop
      cargo
      fd
      ffmpeg
      foot
      fzf
      gemini-cli
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
      radicle-node
      ripgrep
      yt-dlp
      zk
      zoxide

      (pass-nodmenu.withExtensions (ext: with ext; [
        pass-import
        pass-otp
      ]))

      # Language servers
      gopls
      lua-language-server
      markdown-oxide
      nil
      nodePackages.typescript-language-server
      pyright
      rust-analyzer
      terraform-ls

      # AI
      unstable.codex
      unstable.opencode
      unstable.playwright-mcp

      # GUI
      blender
      brave
      emacs-pgtk
      firefox
      gnome-sound-recorder
      gpu-screen-recorder
      kdePackages.kdeconnect-kde
      neovide
      onlyoffice-desktopeditors
      piper
      signal-desktop
      sweethome3d.application
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.khuedoan = {
      home = {
        stateVersion = "23.05";
        activation = {
          dotfiles = ''
            set -eu
            [ -d ~/.git ] \
              || ${pkgs.git}/bin/git init \
              && ${pkgs.git}/bin/git config status.showUntrackedFiles no \
              && ${pkgs.git}/bin/git remote add origin https://github.com/khuedoan/dotfiles \
              && (until ${pkgs.iputils}/bin/ping -c 1 github.com; do sleep 1; done) \
              && ${pkgs.git}/bin/git pull origin master \
              && ${pkgs.git}/bin/git branch --set-upstream-to=origin/master master
          '';
        };
        file = {
          "Pictures/Wallpapers/astronaut-jellyfish.jpg".source = builtins.fetchurl {
            url = "https://github.com/user-attachments/assets/b63195d0-7fe3-4ab5-95c7-20127123836c";
            sha256 = "1g120j4z6665j4wh2g84m4rb24gvzdxyhx9lqym68cwn8ny2j7fz"; # nix-prefetch-url
          };
        };
      };
      services = {
        easyeffects.enable = true;
      };
      systemd.user = {
        services.sync-notes = {
          Unit = {
            Description = "Sync notes";
          };
          Service = {
            Type = "oneshot";
            WorkingDirectory = "%h/Documents/notes";
            Environment = [
              "HOSTNAME=%H"
              "GIT_SSH_COMMAND=/run/current-system/sw/bin/ssh"
            ];
            ExecStart = "${pkgs.writeTextFile {
              name = "sync-notes";
              executable = true;
              text = ''
                #!${pkgs.bash}/bin/sh
                set -eu

                if [ -n "$(${pkgs.git}/bin/git status --porcelain)" ]; then
                  ${pkgs.git}/bin/git add --all
                  if ! ${pkgs.git}/bin/git diff --cached --quiet; then
                    ${pkgs.git}/bin/git commit -m "Update notes from $HOSTNAME"
                  fi
                fi
                ${pkgs.git}/bin/git pull --rebase --strategy-option theirs
                ${pkgs.git}/bin/git push
              '';
            }}";
          };
        };
        timers.sync-notes = {
          Unit = {
            Description = "Sync notes every 5 minutes";
          };
          Timer = {
            OnUnitActiveSec = "5min";
            Persistent = true;
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
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
