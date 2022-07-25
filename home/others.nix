{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
    fzf

    xorg.xev
    xdo # for devour
    xclip
    service-wrapper

    feh
    unzip

    chromium
    rustdesk

    qrencode
    openrgb
    piper

    steam
    discord
    jstest-gtk
    linuxConsoleTools

    teams

    pavucontrol
    gucharmap
    fontforge-gtk

    # candy
    cmatrix
    pipes-rs
    cbonsai
    neofetch
    screenkey
    cava
  ];
}
