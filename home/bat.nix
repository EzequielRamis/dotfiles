{ config, lib, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config.color = "never";
  };
}
