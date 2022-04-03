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
      # It works on Chromium browsers but Firefox
      # localConf = ''
      # <?xml version="1.0"?>
      # <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      # <fontconfig>
      #   <match>
      #     <test name="family">
      #       <string>serif</string>
      #     </test>
      #     <!-- <test name="weight" compare="more">
      #       <int>180</int>
      #     </test> -->
      #     <edit name="weight" mode="assign" binding="strong">
      #       <int>180</int>
      #     </edit>
      #   </match>
      # </fontconfig>
      # '';
    };
  };
}
