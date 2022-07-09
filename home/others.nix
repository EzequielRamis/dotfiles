{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
    fzf

    xorg.xev
    xdo # for devour

    feh

    #thunar
    (xfce.thunar.override { thunarPlugins = [ xfce.thunar-archive-plugin ]; })

    chromium

    neofetch
    qrencode
    xclip
    screenkey
    openrgb
    piper

    steam
    discord

    pavucontrol
  ];
}
