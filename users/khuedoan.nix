{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.khuedoan = {
      home.stateVersion = "23.05";
      services = {
        easyeffects.enable = true;
      };
    };
  };
}
