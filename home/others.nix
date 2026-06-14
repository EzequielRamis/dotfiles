{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.handy.enable = true;
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

    service-wrapper
    wmutils-core
    tesseract
    wl-clipboard
    wtype

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
    teams-for-linux
    tor-browser
    pcsx2
    dolphin-emu

    qrencode
    openrgb
    piper
    mpv
    zoom-us
    teams-for-linux

    xournalpp
    yalc
    copilot-language-server

    calibre
    libmtp
    usbutils
    libreoffice
    blender

    telegram-desktop

    yt-dlp
    pwvucontrol
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
