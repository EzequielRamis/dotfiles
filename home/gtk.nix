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
  };
  home.pointerCursor = {
    name = "Capitaine Cursors - White";
    package = pkgs.capitaine-cursors;
    size = 30;
    x11.enable = true;
    gtk.enable = true;
  };
}
