{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.neofetch ];
  xdg.configFile."neofetch/config.conf".source = ./config.conf;
  xdg.configFile."neofetch/logo.svg".source = ./logo.svg;
}
