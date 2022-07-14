{ config, lib, pkgs, my, ... }:

{
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        uiColor = my.palette."65";
        contrastUiColor = my.palette."68";
        showHelp = false;
      };
    };
  };
}
