{ config, lib, pkgs, ... }:
let
  emacsDir = "$HOME/.emacs.d";
  DOOMDIR = "$HOME/.dotfiles/home/emacs/doom";
  enable = true;
in
{
  programs.emacs = {
    inherit enable;
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
    '';
      # Due to time-outs it is better to doom upgrade manually
      # ${emacsDir}/bin/doom --doomdir ${DOOMDIR} sync
  };
}
