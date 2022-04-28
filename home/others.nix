{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
    fzf
    xorg.xev
    xdo # devour
    feh
    xfce.thunar
    chromium
    neofetch
  ];
}
