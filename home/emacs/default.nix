{ config, lib, pkgs, ... }:
let
  emacsDir = "$HOME/.emacs.d";
  DOOMDIR = builtins.toString ./doom;
in
{
  programs.emacs = {
    enable = false;
    package = pkgs.emacsPgtkGcc;
  };

  home.sessionVariables = {
    inherit DOOMDIR;
  };

  home.sessionPath = [ "${emacsDir}/bin" ];

  home.packages = with pkgs; [
    fd
    sqlite
  ];

  home.activation = {
    doom-sync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${emacsDir}"
      git -C ${emacsDir} init
      git -C ${emacsDir} pull https://github.com/hlissner/doom-emacs.git
      ${emacsDir}/bin/doom --doomdir ${DOOMDIR} sync
    '';
  };
}
