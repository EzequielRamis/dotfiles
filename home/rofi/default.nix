{ config, pkgs, my, ... }: {
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-emoji ];
    extraConfig = {
      modi = "drun,emoji";
      font = "sans 14";
      display-drun = "Applications";
      drun-display-format = "{name}";
      cycle = false;
    };
    theme = ./index.rasi;
  };
  xdg.configFile."rofi/index.rasi".source = ./index.rasi;
  xdg.configFile."rofi/power.rasi".source = ./power.rasi;
  xdg.configFile."rofi/theme.rasi".text = let t = my.theme;
  in ''
    * {
      t-bg: ${t."0BF"}CC;
      t-fg: ${t."0BF"};
      t-border: ${t."0BC"};
      t-prompt: ${t."0B5"};
      t-text: ${t."0B0"};
      t-enter: ${t."0BD"};
      t-select: ${t."0BE"};
    }
  '';
}
