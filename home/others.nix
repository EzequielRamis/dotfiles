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
    jetbrains.clion

    qrencode
    openrgb
    piper

    steam
    discord
    jstest-gtk
    linuxConsoleTools
    lutris
    wine
    winetricks
    calibre
    libmtp
    usbutils

    teams
    awsvpnclient

    pavucontrol
    gucharmap
    fontforge-gtk
    gnome.simple-scan

    # candy
    cmatrix
    pipes-rs
    cbonsai
    neofetch
    screenkey
    cava
  ];
}
