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
    teams

    pavucontrol

    # candy
    cmatrix
    pipes-rs
    cbonsai
    neofetch
    screenkey
    cava
  ];
}
