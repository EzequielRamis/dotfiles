{ config, lib, pkgs, ... }:
{
  programs.doom-emacs = {
    enable = false;
    doomPrivateDir = ./doom;
    emacsPackage = pkgs.emacsPgtkGcc;
  };
}
