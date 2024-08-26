{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
    fzf
    vscode.fhs
    nix-alien

    xorg.xev
    xdo # for devour
    xdotool
    xclip
    service-wrapper
    wmutils-core
    tesseract

    nodejs

    feh
    zip
    unzip
    ffmpeg

    google-chrome
    # jetbrains.clion
    tor-browser-bundle-bin
    qbittorrent

    qrencode
    openrgb
    piper
    vlc
    stremio
    droidcam
    xournalpp
    nodePackages.yalc

    calibre
    libmtp
    usbutils

    tdesktop

    yt-dlp
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
