{ pkgs, lib, ... }: {
  home.keyboard = {
    layout = "es";
    options = [ "caps:super" ];
  };
  xsession = {
    enable = true;
    numlock.enable = true;
    initExtra = ''
      openrgb -p None.orp

      xsettingsd -c ~/.xsettingsd-light.conf &
      kitty +kitten themes --reload-in=all --config-file-name ~/.config/kitty/mytheme.conf Mylight

      # cursor speed
      xset r rate 400 40
      # mouse acceleration
      xset m 0 0
      # screen saver off (not working)
      xset -dpms
      xset s off
      xsetroot -cursor_name left_ptr

      ls ~/Pictures/Wallpapers/Light -1 | shuf -n1 > /tmp/current_wallpaper.txt
      feh --bg-fill --no-fehbg ~/Pictures/Wallpapers/Light/"$(cat /tmp/current_wallpaper.txt)" &

      eww open bar &
      pcmanfm -d &
      dunst &
    '';
  };
  home.pointerCursor = {
    name = "capitaine-cursors-white";
    package = pkgs.capitaine-cursors;
    size = 30;
    x11.enable = true;
  };
}
