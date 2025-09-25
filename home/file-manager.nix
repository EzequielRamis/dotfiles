{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ pcmanfm file-roller ffmpegthumbnailer ];
  xdg.dataFile."file-manager/actions/wallpaper.desktop".text = ''
    [Desktop Entry]
    Type=Action
    Name=Set as wallpaper
    Icon=user-desktop
    Profiles=profile-zero;

    [X-Action-Profile profile-zero]
    MimeTypes=image/*;
    Exec=fehbg set %f
    Name=Default profile
    SelectionCount==1
  '';
}
