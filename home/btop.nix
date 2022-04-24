{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ btop ];
  xdg.desktopEntries.btop = {
    type = "Application";
    name = "Btop";
    exec = "btop";
    terminal = true;
    genericName = "Resource monitor";
  };
  xdg.configFile."btop/btop.conf".text = ''
    color_theme = "TTY"
    theme_background = False
    truecolor = False
    vim_keys = True
    rounded_corners = True
    graph_symbol = "braille"
    update_ms = 200
  '';
}
