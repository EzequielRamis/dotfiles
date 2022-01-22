{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.nix-doom-emacs.hmModule ];

  programs.emacs.enable = true;
  programs.emacs.package = pkgs.emacsPgtkGcc; # remove if controlled by nix-doom-emacs; cf. in flakes.nix
  services.emacs.enable = true;

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom;
  };
}
