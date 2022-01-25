{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    initExtraFirst = ''
      export GPG_TTY=$TTY
    '';
  };
}
