{ pkgs, ... }:
with builtins;
let
  dirsFrom = 
    with pkgs.lib;
    dir: map (m: "${dir}/${m}") (attrNames (filterAttrs (_: type: type == "directory") (readDir dir)));

  home-modules = 
    filter (d: pathExists "${d}/default.nix") (dirsFrom ./.);
in
{
  imports = home-modules;

  home.packages = with pkgs; [
    steam
    vscode
  ];

  programs.home-manager.enable = true; 
}
