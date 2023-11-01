{ pkgs, ... }:

{
  # TODO remove after NixOS 23.11
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_5;
  };

  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services = {
    auto-cpufreq = {
      # TODO find a way to set epp to power, not balance_power
      # Run these commands for now
      # sudo systemctl stop auto-cpufreq.service
      # echo "power" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
      enable = true;
      settings = {
        battery = {
           governor = "powersave";
        };
        charger = {
           governor = "performance";
        };
      };
    };
    kanata = {
      enable = true;
      keyboards = {
        builtin = {
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];
          config = ''
            (defalias
              xcp (tap-hold-press 10 200 esc lctl)
              fn  (layer-toggle function)
            )

            (defsrc
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rctl
            )

            (deflayer default
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              @xcp _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _
              _    lalt lmet           _              @fn  _
            )

            (deflayer function
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    lft  down up   rght _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _              _              _    _
            )
          '';
        };
      };
    };
  };

  networking = {
    hostName = "thinkpadz13";
  };

  users.users.khuedoan = {
    packages = with pkgs; [
      steam
    ];
  };

  home-manager = {
    users.khuedoan = {
      wayland.windowManager.sway = {
        config = {
          output = {
            "eDP-1" = {
              scale = "1.25";
            };
          };
        };
      };
    };
  };
}
