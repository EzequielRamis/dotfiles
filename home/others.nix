{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
    xorg.xev
    feh
  ];
}
