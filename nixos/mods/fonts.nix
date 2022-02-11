{ pkgs, ... }: {
  fonts = {
    fonts = with pkgs; [
      fira-code
      twitter-color-emoji
      emacs-all-the-icons-fonts
      my.apple-nerd-fonts
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Twitter Color Emoji" ];
        monospace = [ "LigaSF Mono Nerd Font" "FiraCode" ];
      };
    };
  };
}
