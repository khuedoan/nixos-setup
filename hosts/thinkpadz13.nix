{ pkgs, ... }:

{
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services = {
    tlp = {
      enable = true;
      settings = {
        CPU_DRIVER_OPMODE_ON_BAT = "active";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wifi wwan";
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
}
