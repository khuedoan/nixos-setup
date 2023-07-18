{ config, pkgs, ... }:

{
  imports = [
    # TODO find a way to generate hardware configuration?
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # TODO make it optional for non-AMD GPU
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
    # TODO do we need this?? currently disabled because FPS lock in Overwatch
    # extraPackages = with pkgs; [
    #   amdvlk
    # ];
    # extraPackages32 = with pkgs; [
    #   driversi686Linux.amdvlk
    # ];
  };

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

  nixpkgs.config.allowUnfree = true;

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        i3status-rust
        mako
        pavucontrol
        swayidle
        swaylock
        wl-clipboard
        wofi
        zathura
      ];
    };
    light.enable = true;
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
        maxfit67 = {
          devices = [
            "/dev/input/by-id/usb-RONGYUAN_2.4G_Wireless_Device-if02-event-kbd"
          ];
          config = ''
            (defalias
              xcp (tap-hold-press 10 200 esc lctl)
              fn  (layer-toggle function)
            )

            (defsrc
              esc  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rctl
            )

            (deflayer default
              grv  _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              @xcp _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _
              _    lalt lmet           _              @fn  _
            )

            (deflayer function
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    left down up   rght _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _              _              _    _
            )
          '';
        };
      };
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.khuedoan = {
    isNormalUser = true;
    description = "Khue Doan";
    extraGroups = [
      "docker"
      "networkmanager"
      "video"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      aria
      audacity
      cargo
      fd
      firefox
      fzf
      gh
      go
      jq
      kitty
      kubectl
      kubernetes-helm
      kustomize
      nnn
      nodePackages.npm
      nodePackages.yarn
      nodejs
      obs-studio
      ripgrep
      zoxide

      (pass.withExtensions (ext: with ext; [
        pass-otp
      ]))

      # TODO split to a different file?
      # Games
      bottles
    ];
  };
}
