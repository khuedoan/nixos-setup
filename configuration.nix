# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # TODO find a way to generate hardware configuration?
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        bamboo # Vietnamese
      ];
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    gnumake
    neovim
    tmux
    tree
    unzip
    watch
    python3
    zsh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
    zsh.enable = true;
    sway.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
      ];
    })
  ];

  # List services that you want to enable:

  services = {
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    kanata = {
      enable = true;
      keyboards = {
        common = {
          devices = [
            # TODO autodetect?
            "/dev/input/by-id/usb-RONGYUAN_2.4G_Wireless_Device-if02-event-kbd"
          ];
          config = ''
            (defalias
              xcp (tap-hold-press 200 200 esc lctl)
              fn  (layer-toggle function)
            )

            (defsrc
              esc  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rctl
            )

            (deflayer qwerty
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              @xcp a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lalt lmet           spc            @fn  rctl
            )

            (deflayer function
              _    1    2    3    _    _    _    _    _    _    _    _    _    _
              _    4    5    6    _    _    _    _    _    _    _    _    _    _
              _    7    8    9    _    _    left down up   rght _    _    _
              _    _    0    _    _    _    _    _    _    _    _    _
              _    _    _              _              _    _
            )
          '';
        };
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  virtualisation.docker = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.khuedoan = {
    isNormalUser = true;
    description = "Khue Doan";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      aria
      aria2
      cargo
      firefox
      fzf
      gh
      go
      jq
      kubectl
      kubernetes-helm
      kustomize
      nnn
      nodePackages.npm
      nodePackages.yarn
      nodejs
      ripgrep
      zoxide
      kitty
      wl-clipboard
    ];
  };
}
