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
    networkmanager = {
      enable = true;
    };
    firewall = {
      checkReversePath = "loose";
    };
  };

  systemd = {
    services = {
      NetworkManager-wait-online = {
        enable = false;
      };
    };
  };

  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      type = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        bamboo
      ];
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
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    curl
    file
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
      wrapperFeatures = {
        gtk = true;
      };
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
    virt-manager = {
      enable = true;
    };
  };

  fonts.packages = with pkgs; [
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
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    blueman.enable = true;
    tailscale.enable = true;
    gvfs.enable = true;
    yggdrasil = {
      enable = true;
      persistentKeys = true;
      settings = {
        Peers = [
          # https://publicpeers.neilalexander.dev
          "tls://sin.yuetau.net:6643" # Singapore
          "tls://mima.localghost.org:443" # Philippines
          "tls://133.18.201.69:54232" # Japan
          "tls://vpn.itrus.su:7992" # Netherlands
          "tls://ygg.jjolly.dev:3443" # United States
        ];
      };
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      autoPrune = {
        enable = true;
        flags = [
          "--all"
          "--volumes"
        ];
      };
    };
    libvirtd = {
      enable = true;
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
