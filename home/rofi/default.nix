{ config, pkgs, my, ... }: {
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-emoji ];
    extraConfig = {
      modi = "drun,emoji";
      font = "sans 14";
    };
    theme = let inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "White";
      };
      window = {
        background-color = mkLiteral "${my.theme."0BF"}CC";
        border-color = mkLiteral my.theme."0BC";
        border = mkLiteral "1px";
        border-radius = mkLiteral "8px";
      };
    };
  };
}
