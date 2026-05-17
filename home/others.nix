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
    qalculate-gtk

    ripgrep
    sqlite
    wordnet

    xev
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
    helium
    # jetbrains.clion
    jetbrains-toolbox
    slack
    tor-browser
    qbittorrent
    pcsx2
    dolphin-emu

    qrencode
    openrgb
    piper
    vlc
    # stremio qtengine deprecated
    zoom-us
    teams-for-linux

    xournalpp
    nodePackages.yalc
    copilot-language-server

    calibre
    libmtp
    usbutils
    libreoffice

    telegram-desktop

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
