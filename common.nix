{ pkgs, lib, ... }:
with (import ./helpers.nix);
{
  imports = modulesFrom ./common;
}
