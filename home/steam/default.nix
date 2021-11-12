{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    steam
  ];
  
  programs.steam.enable = true;
}
