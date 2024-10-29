{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ gnucash ];
  xdg.desktopEntries.gnucash = {
    type = "Application";
    mimeType = [ "application/x-gnucash" ];
    name = "GnuCash";
    genericName = "Finance Management";
    comment = "Manage your finances, accounts, and investments";
    exec = "env LANGUAGE=es_AR.utf8 LANG=es_AR.utf8 gnucash";
  };
}
