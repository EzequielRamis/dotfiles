{ config, pkgs, my, ... }: {
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-emoji ];
    extraConfig = {
      modi = "drun,emoji";
      font = "sans 16px";
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
      t-bg: ${t."0C0"}CC;
      t-fg: ${t."0C0"};
      t-border: ${t."0C2"};
      t-prompt: ${t."0C5"};
      t-text: ${t."0CE"};
      t-select: ${t."0C0"};
    }
  '';
}
