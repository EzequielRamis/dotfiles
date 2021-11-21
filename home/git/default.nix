{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName  = "Ezequiel Ramis";
    userEmail = "ezequielramis.hello@gmail.com";
  };
}