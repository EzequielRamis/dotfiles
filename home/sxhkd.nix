{ config, lib, pkgs, ... }:
{
  xsession.windowManager.sxhkd = {
    enable = true;
    keybindings = {
      "super + space" = "rofi -show run";
    };
  };
}
