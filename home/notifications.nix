{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ libnotify ];
  services.dunst = { enable = true; };
}
