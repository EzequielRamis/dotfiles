{ config, lib, pkgs, ... }:
{
  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      "border_width" = 2;
      "split_ratio" = 0.52;
      "gapless_monocle" = true;
    };
    monitors = {
      "HDMI-0" = [ "web" "terminal" "III" "IV" ];
    };
  };
}
