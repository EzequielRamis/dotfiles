{ config, lib, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      map-syntax = [ "*.conf:INI" ];
    };
  };
}
