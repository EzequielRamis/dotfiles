{ pkgs, lib, ... }:
with builtins;
let
  dirsFrom = 
    with pkgs.lib;
    dir: map (m: "${dir}/${m}") (attrNames (filterAttrs (_: type: type == "directory") (readDir dir)));

  # hm = filter (d: pathExists "${d}/default.nix") (dirsFrom ./home);
  hm = dirsFrom ./home;
in
{
  programs.home-manager.enable = true; 
  imports = hm;
}
