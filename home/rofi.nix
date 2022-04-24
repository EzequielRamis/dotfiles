{ config, lib, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-emoji ];
    extraConfig = {
      modi = "drun,emoji";
      font = "sans 14";
    };
  };
}
