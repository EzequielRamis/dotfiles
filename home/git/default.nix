{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    git
  ];
  
  programs.git = {
    enable = true;
    userName  = "Ezequiel Ramis";
    userEmail = "ezequielramis.hello@gmail.com";
  };
}