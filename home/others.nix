{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ jq jless fzf xorg.xev feh xfce.thunar chromium ];
}
