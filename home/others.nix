{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
    fzf

    xorg.xev
    xdo # for devour
    xdotool
    xclip
    scrot
    service-wrapper

    feh
    unzip

    chromium
    jetbrains.clion

    qrencode
    openrgb
    piper
    obs-studio
    vlc

    steam
    (discord.override { nss = nss_latest; })
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
    screenkey
    cava
  ];
}
