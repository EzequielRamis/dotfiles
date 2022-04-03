{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jq
    jless
  ];
}
