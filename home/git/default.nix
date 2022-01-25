{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName  = "Ezequiel Ramis";
    userEmail = "ezequielramis.hello@gmail.com";
    signing = {
      key = "BF25118B1BFFE56E";
      signByDefault = true;
    };
  };
}