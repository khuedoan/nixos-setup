{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.khuedoan = {
      home.stateVersion = "23.05";
      services = {
        easyeffects.enable = true;
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
            color = "#282c34";
            indicator-idle-visible = true;
            show-failed-attempts = true;
          };
        };
      };
    };
  };
}
