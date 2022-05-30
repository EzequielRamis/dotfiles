{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ eww ];
  xdg.configFile."eww/eww.yuck".source = ./eww.yuck;
  xdg.configFile."eww/eww.scss".source = ./eww.scss;

  xdg.configFile."eww/scripts/workspace".source = ./scripts/workspace;
  xdg.configFile."eww/scripts/workspace".executable = true;
}
