{ config, lib, pkgs, secrets, ... }:

{
  home.packages = with pkgs;
    secrets.homePackages ++ [
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
      teams

      pavucontrol

      # candy
      cmatrix
      pipes-rs
      cbonsai
      neofetch
      screenkey
    ];
}
