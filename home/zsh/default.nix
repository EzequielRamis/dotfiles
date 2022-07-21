{ config, pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    initExtraFirst = builtins.readFile ./initExtraFirst.zsh;
    initExtra = builtins.readFile ./initExtra.zsh;
    shellAliases = {
      cat = "bat";
      e = ''devour emacsclient -c -a \"\"'';
      qrclip = "xclip -o | qrencode -t utf8";
      clear = ''printf "\033[2J\033[3J\033[1;1H"'';
    };
  };
}
