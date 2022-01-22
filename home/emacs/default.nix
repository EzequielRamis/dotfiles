{ config, lib, pkgs, ... }:
let
  enable = false;
  doomSyncScript = pkgs.writeScriptBin "doom-sync-git" ''
    #!${pkgs.runtimeShell}
    export PATH=$PATH:${lib.makeBinPath [ pkgs.git pkgs.sqlite pkgs.unzip ]}
    if [ ! -d $HOME/.emacs.d/.git ]; then
      mkdir -p $HOME/.emacs.d
      git -C $HOME/.emacs.d init
    fi
    if [ $(git -C $HOME/.emacs.d rev-parse HEAD) != ${pkgs.doomEmacsRevision} ]; then
      git -C $HOME/.emacs.d fetch https://github.com/hlissner/doom-emacs.git || true
      git -C $HOME/.emacs.d checkout ${pkgs.doomEmacsRevision} || true
    fi
  '';
in;
{
  # programs.doom-emacs = {
  #   enable = false;
  #   doomPrivateDir = ./doom;
  #   emacsPackage = pkgs.emacsPgtkGcc;
  # };
  home.sessionVariables = {
    DOOMDIR = ./doom;
    PATH = [ "$HOME/.emacs.d/bin" ];
  };

  home.packages = with pkgs; [
    fd
    sqlite
    doomSyncScript
  ];

  services.emacs = {
    inherit enable;
    package = pkgs.emacsPgtkGcc;
  };
}
