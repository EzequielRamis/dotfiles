{ config, lib, pkgs, ... }:

{
  home.sessionPath = [ "$HOME/.dotfiles/bin" ];
  home.extraActivationPath = with pkgs; [ git unzip ];
}
