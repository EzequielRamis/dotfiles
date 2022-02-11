{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    profileExtra = ''
      export GPG_TTY=$TTY
    '';
    initExtraFirst = ''
      setopt nobanghist
    '';
    initExtra = ''
      PROMPT=$'\n'"𝝘, %(4~|%-1~/.../%2~|%~)"''$'\n'"𝝺. "
    '';
  };
}
