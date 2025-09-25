{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
    fzf
    vscode.fhs
    nix-alien
    entr
    file

    ripgrep
    sqlite
    wordnet

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
    copilot-language-server

    calibre
    libmtp
    usbutils
    libreoffice

    tdesktop

    yt-dlp
    pavucontrol
    gucharmap
    fontforge-gtk
    simple-scan

    # candy
    cmatrix
    pipes-rs
    cbonsai
    screenkey
    cava
  ];
}
