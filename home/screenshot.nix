{
  config,
  lib,
  pkgs,
  my,
  ...
}:

{
  home.packages = with pkgs; [
    grim
    slurp
  ];
  programs.satty.enable = true;
  # services.flameshot = {
  #   enable = true;
  #   settings = {
  #     General = {
  #       uiColor = my.palette."65";
  #       contrastUiColor = my.palette."68";
  #       showHelp = false;
  #       useGrimAdapter = true;
  #     };
  #   };
  # };
}
