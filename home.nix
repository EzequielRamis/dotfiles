{ pkgs, lib, ... }:
with builtins;
let
  hm = filter (d: pathExists "${d}/default.nix")
        (map (m: ./. + "/home/${m}")
          (attrNames (readDir ./home)));
in
{
  programs.home-manager.enable = true; 
  imports = hm;
}
