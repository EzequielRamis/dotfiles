{ pkgs, lib, ... }:
with (import ./helpers.nix);
{
  programs.home-manager.enable = true; 
  imports = modulesFrom ./home;
}
