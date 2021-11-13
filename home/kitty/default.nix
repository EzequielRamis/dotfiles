{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    kitty
  ];
}
