{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
  };
}
