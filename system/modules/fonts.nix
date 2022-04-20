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
        serif = [ "New York Small" "New York Medium" "New York Large" "New York Extra Large" ];
        sansSerif = [ "SF Pro Text" "SF Pro Display" ];
      };
    };
  };
}
