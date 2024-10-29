{ config, lib, pkgs, ... }:

{
  xdg = {
    enable = true;
    mime.enable = true;
    userDirs.enable = true;
    userDirs.createDirectories = true;
    portal.config = { common = { default = [ "gtk" ]; }; };
  };
}
