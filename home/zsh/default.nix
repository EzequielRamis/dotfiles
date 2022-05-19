{ config, pkgs, lib, ... }: {
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
    initExtraFirst = builtins.readFile ./initExtraFirst.zsh;
    initExtra = builtins.readFile ./initExtra.zsh;
    shellAliases = {
      cat = "bat";
      ee = "emacs &";
      e = ''devour emacsclient -c -a \"\"'';
    };
  };
}
