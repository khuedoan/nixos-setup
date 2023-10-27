{ pkgs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.khuedoan = {
      home.stateVersion = "23.05";
      services = {
        easyeffects.enable = true;
        swayidle = {
          enable = true;
          events = [
            { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock -f"; }
          ];
          timeouts = [
            { timeout = 600; command = "${pkgs.swaylock}/bin/swaylock -f"; }
            { timeout = 660; command = "${pkgs.sway}/bin/swaymsg \"output * power off\""; resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * power on\""; }
          ];
        };
      };
      wayland.windowManager.sway = {
        enable = true;
        config = rec {
          modifier = "Mod4";
          terminal = "foot";
          menu = "rofi -show drun -show-icons";
          left = "h";
          down = "j";
          up = "k";
          right = "l";
          bars = [
            {
              position = "top";
              fonts = {
                size = 10.0;
              };
              statusCommand = "i3status-rs ~/.config/i3status-rust/config-default.toml";
            }
          ];
          floating = {
            titlebar = true;
          };
          focus = {
            followMouse = false;
          };
          gaps = {
            smartBorders = "on";
            smartGaps = true;
            inner = 10;
          };
          input = {
            "type:pointer" = {
              accel_profile = "flat";
            };
            "type:touchpad" = {
              middle_emulation = "enabled";
              natural_scroll = "enabled";
              tap = "enabled";
            };
          };
          keybindings = {
            "${modifier}+Space" = "exec rofi -show drun -show-icons";
            "${modifier}+Return" = "exec ${terminal}";
            "${modifier}+Shift+q" = "kill";
            "${modifier}+d" = "exec ${menu}";

            "${modifier}+${left}" = "focus left";
            "${modifier}+${down}" = "focus down";
            "${modifier}+${up}" = "focus up";
            "${modifier}+${right}" = "focus right";

            "${modifier}+Shift+${left}" = "move left";
            "${modifier}+Shift+${down}" = "move down";
            "${modifier}+Shift+${up}" = "move up";
            "${modifier}+Shift+${right}" = "move right";

            "${modifier}+b" = "splith";
            "${modifier}+v" = "splitv";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+a" = "focus parent";

            "${modifier}+Shift+f" = "floating toggle";

            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";

            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";

            "${modifier}+0" = "scratchpad show";
            "${modifier}+Shift+0" = "move scratchpad";

            "${modifier}+r" = "mode resize";

            # TODO clean up
            "${modifier}+ctrl+l" = "exec swaylock";
            "${modifier}+ctrl+e" = "exec [ \"$(echo -n 'yes\\nno' | rofi -dmenu)\" = \"yes\" ] && swaymsg exit";
            "${modifier}+ctrl+r" = "reload";
            "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
            "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

            "Print" = "exec grim - | wl-copy";
            "ctrl+Print" = "exec grim -g \"\$(slurp)\" - | wl-copy";

            "${modifier}+Shift+p" = "exec MENU='rofi -dmenu -p OTP -i' otp";

            "ctrl+Shift+Space" = "exec ibus-next";
          };
          output = {
            "DP-3" = {
              mode = "2560x1440@180hz";
            };
            "*" = {
              bg = "~/Pictures/Wallpapers/LostInMindNord.jpg fill";
            };
          };
          startup = [
            { command = "autotiling"; always = true; }
            { command = "systemctl --user start easyeffects"; }
            { command = "ibus-daemon -drx"; }
          ];
          window = {
            titlebar = false;
          };
        };
        wrapperFeatures = {
          gtk = true;
        };
      };
      programs = {
        i3status-rust = {
          enable = true;
          bars = {
            default = {
              theme = "native";
              icons = "material-nf";
              blocks = [
                {
                  block = "cpu";
                }
                {
                  block = "disk_space";
                }
                {
                  block = "memory";
                }
                {
                  block = "sound";
                }
                {
                  block = "time";
                }
              ];
            };
          };
        };
        swaylock = {
          enable = true;
          settings = {
            color = "#000000";
            indicator-idle-visible = true;
            show-failed-attempts = true;
          };
        };
      };
    };
  };
}
