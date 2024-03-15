{ pkgs, ... }:

{
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  networking = {
    hostName = "ryzentower";
  };

  services = {
    kanata = {
      enable = false;
      keyboards = {
        maxfit67 = {
          devices = [
            "/dev/input/by-id/usb-RONGYUAN_2.4G_Wireless_Device-if02-event-kbd"
          ];
          config = ''
            (defalias
              xcp (tap-hold-press 10 200 esc lctl)
              fn  (layer-toggle function)

              mau (movemouse-accel-up    5 800 1 30)
              mal (movemouse-accel-left  5 800 1 30)
              mad (movemouse-accel-down  5 800 1 30)
              mar (movemouse-accel-right 5 800 1 30)

              mwu (mwheel-up   50 120)
              mwd (mwheel-down 50 120)
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
              _    lalt lmet           _              @fn  (layer-switch gaming)
            )

            (deflayer function
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    mmid @mau @mwu _    _    _    _    _    _    _    _    _
              _    mlft @mal @mad @mar mrgt @mal @mad @mau @mar _    _    _
              _    _    _    _    @mwd _    _    mlft mmid mrgt _    _
              _    _    _              @fn            _    _
            )

            (deflayer gaming
              esc  _    _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _    _    _
              lctl _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _    _    _    _    _    _    _    _    _    _
              _    _    _              _              _    (layer-switch default)
            )
          '';
        };
      };
    };
  };

  users.users.khuedoan = {
    packages = with pkgs; [
      bottles
      steam
    ];
  };

  home-manager = {
    users.khuedoan = {
      wayland.windowManager.sway = {
        config = {
          output = {
            "DP-3" = {
              mode = "2560x1440@180hz";
            };
          };
        };
      };
    };
  };
}
