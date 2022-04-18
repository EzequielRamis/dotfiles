{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.whitesur-gtk-theme;
      name = "WhiteSur-light";
    };
  };
}
