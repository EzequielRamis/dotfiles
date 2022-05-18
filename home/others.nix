{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
    fzf
    xorg.xev
    xdo # for devour
    feh
    xfce.thunar
    chromium
    neofetch
    fontforge-gtk
    gucharmap
    lxappearance
  ];
}
