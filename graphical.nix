{ config, pkgs, ... }:

{
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-bamboo
        ];
        settings = {
          inputMethod = {
            "Groups/0" = {
              "Name" = "Default";
              "Default Layout" = "us";
              "DefaultIM" = "keyboard-us";
            };
            "Groups/0/Items/0" = {
              "Name" = "keyboard-us";
            };
            "Groups/0/Items/1" = {
              "Name" = "bamboo";
            };
          };
          globalOptions = {
            "Behavior" = {
              "ShowInputMethodInformation" = "False";
            };
            "Hotkey/TriggerKeys" = {};
            "Hotkey/EnumerateForwardKeys" = {
              "0" = "Control+Shift+space";
            };
          };
          addons = {
            bamboo = {
              globalSection = {
                InputMethod = "Telex 2";
              };
            };
          };
        };
      };
    };
  };

  programs = {
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
        libnotify
        mako
        mpv
        pavucontrol
        pcmanfm
        rofi-wayland
        slurp
        soteria
        swayidle
        swaylock
        wl-clipboard
        xdg-utils
        zathura
      ];
    };
    light.enable = true;
    dconf.enable = true;
    virt-manager = {
      enable = true;
    };
    gpu-screen-recorder.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
    };
  };
}
