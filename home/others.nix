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
    service-wrapper
    wmutils-core
    tesseract

    nodePackages.yalc

    feh
    zip
    unzip
    ffmpeg

    google-chrome
    jetbrains.clion
    tor-browser-bundle-bin

    qrencode
    openrgb
    piper
    vlc
    stremio
    droidcam
    xournalpp

    calibre
    libmtp
    usbutils

    teams
    tdesktop

    youtube-dl
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
