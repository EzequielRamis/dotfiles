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
      name = "Capitaine Cursors";
      package = pkgs.capitaine-cursors;
      size = 30;
    };
  };
}
