{ config, lib, pkgs, ... }:
let
in
{
  programs.emacs = {
    enable = false;
    package = pkgs.emacsPgtkGcc;
  };

  home.sessionVariables.DOOMDIR = ./doom;
  home.sessionPath = [ "$HOME/.emacs.d/bin" ];

  home.packages = with pkgs; [
    fd
    sqlite
  ];

  home.activation = {
    doom-sync = lib.hm.dag.entryAfter [] ''
      mkdir -p "$HOME/.emacs.d"
      git -C "$HOME/.emacs.d"
      git -C $HOME/.emacs.d fetch https://github.com/hlissner/doom-emacs.git || true
      git -C $HOME/.emacs.d checkout ${pkgs.doomEmacsRevision} || true
    '';
  };
}
