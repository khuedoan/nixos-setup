{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.khuedoan = {
    home.stateVersion = "23.05";
    services = {
      easyeffects.enable = true;
    };
  };
}
