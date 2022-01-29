{ pkgs, ... }:
{
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [ "FiraCode" ];
      })
      twitter-color-emoji
      emacs-all-the-icons-fonts
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Twitter Color Emoji" ];
        monospace = [ "FiraCode Nerd Font" ];
      };
    };
  };
}
