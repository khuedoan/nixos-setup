{ config, pkgs, ... }:

{
  imports = [
    # TODO find a way to generate hardware configuration?
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware = {
    bluetooth.enable = true;
  };

  networking = {
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        bamboo
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    gnumake
    neovim
    python3
    tmux
    tree
    unzip
    watch
  ];

  programs = {
    zsh = {
      enable = true;
      loginShellInit = ''
        if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
          exec sway
        fi
      '';
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        autotiling
        feh
        grim
        i3status-rust
        mako
        mpv
        pavucontrol
        pcmanfm
        rofi-wayland
        slurp
        swayidle
        swaylock
        wl-clipboard
        xdg-utils
        zathura
      ];
    };
    light.enable = true;
    dconf.enable = true;
    direnv = {
      enable = true;
      silent = true;
    };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services = {
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    blueman.enable = true;
    # TODO only enable Tailscale when needed for now due to battery drain
    # https://github.com/tailscale/tailscale/issues/4891
    tailscale.enable = false;
    gvfs.enable = true;
    yggdrasil = {
      enable = true;
      persistentKeys = true; # /var/lib/yggdrasil/keys.json
      settings = {
        Peers = [
          # https://publicpeers.neilalexander.dev
          "tcp://sin.yuetau.net:6642"
          "tcp://mima.localghost.org:1996"
        ];
      };
    };
  };

  security = {
    polkit.enable = true;
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      autoPrune.enable = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
