# For now the best way to manage doom emacs is to only use bin/doom and nix the
# least possible
{ config, lib, pkgs, ... }:
let emacsDir = "$HOME/.emacs.d";
in {
  programs.emacs = {
    enable = true;
  };

  home.sessionVariables.DOOMDIR = "~/.doom.d";
  home.sessionPath = [ "${emacsDir}/bin" ];
  home.packages = with pkgs; [ fd ripgrep nixfmt ];

  home.activation = {
    doom-clone = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d ${emacsDir} ]; then
        git clone https://github.com/hlissner/doom-emacs.git ${emacsDir}
      fi
    '';
  };
}
