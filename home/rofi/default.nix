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
  xdg.configFile."rofi/theme.rasi".text = let t = my.palette;
  in ''
    * {
      t-bg: ${t."00"}CC;
      t-fg: ${t."00"};
      t-border: ${t."04"};
      t-prompt: ${t."05"};
      t-text: ${t."0E"};
      t-select: ${t."00"};
    }
  '';
}
