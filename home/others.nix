{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
    fzf

    xorg.xev
    xdo # for devour
    xclip

    feh
    unzip

    chromium

    qrencode
    openrgb
    piper

    steam
    discord

    pavucontrol

    # candy
    cmatrix
    pipes-rs
    cbonsai
    neofetch
    screenkey
  ];
}
