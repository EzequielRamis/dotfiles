{ config, pkgs, lib, ... }: {
  programs.kitty = {
    enable = true;
    font.name = "mono";
    font.size = 16;
  };
}
