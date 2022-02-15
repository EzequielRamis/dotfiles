{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    firefox
  ];
  home.sessionVariables.MOZ_ENABLE_WAYLAND = 1;
}
