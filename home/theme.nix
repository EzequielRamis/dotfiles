{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.whitesur-gtk-theme;
      name = "WhiteSur-light";
    };
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur";
    };
    font = {
      name = "SF Pro Text";
      size = 11;
    };
    cursorTheme = {
      name = "capitaine-cursors-white";
      package = pkgs.capitaine-cursors;
      size = 30;
    };
  };
  home.packages = [ pkgs.xsettingsd ];
  home.file.".xsettingsd-light.conf".text = ''
    Net/ThemeName "WhiteSur-light"
  '';
  home.file.".xsettingsd-dark.conf".text = ''
    Net/ThemeName "WhiteSur-dark"
  '';
}
