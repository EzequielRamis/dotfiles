{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.pcmanfm ];
  xdg.dataFile."file-manager/actions/wallpaper.desktop".text = ''
    [Desktop Entry]
    Type=Action
    Name=Set as wallpaper
    Icon=user-desktop
    Profiles=profile-zero;

    [X-Action-Profile profile-zero]
    MimeTypes=image/*;
    Exec=feh --bg-fill --no-fehbg %f
    Name=Default profile
    SelectionCount==1
  '';
}
