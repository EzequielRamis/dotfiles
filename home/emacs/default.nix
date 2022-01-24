# For now the best way to manage doom emacs is to only use bin/doom and nix the
# least possible
{ config, lib, pkgs, ... }:
let
  emacsDir = "$HOME/.emacs.d";
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc;
  };

  home.file.".doom.d" = {
    source = ./doom;
    recursive = true;
  };

  home.sessionPath = [ "${emacsDir}/bin" ];

  home.packages = with pkgs; [
    fd
    sqlite
  ];

  home.activation = {
    doom-clone = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d ${emacsDir} ]; then
        mkdir -p "${emacsDir}"
        git -C ${emacsDir} clone https://github.com/hlissner/doom-emacs.git
      fi
    '';
  };
}
