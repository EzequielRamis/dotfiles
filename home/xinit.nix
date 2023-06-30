{ pkgs, lib, ... }: {
  home.keyboard = {
    layout = "us";
    variant = "altgr-intl";
    options = [ "caps:super" ];
  };
  xsession = {
    enable = true;
    numlock.enable = true;
    initExtra = ''
      openrgb -p None.orp

      xsettingsd -c ~/.xsettingsd-light.conf &
      kitty +kitten themes --reload-in=all --config-file-name mytheme.conf Mylight

      # cursor speed
      xset r rate 400 50
      # mouse acceleration
      xset m 0 0
      # screen saver off (not working)
      xset -dpms
      xset s off
      xsetroot -cursor_name left_ptr

      xsetwacom set "Wacom Intuos5 touch S Finger touch" Touch off
      xsetwacom set "Wacom Intuos5 touch S Pen stylus" Rotate half
      xsetwacom set "Wacom Intuos5 touch S Pen stylus" Mode Relative
      xsetwacom set "Wacom Intuos5 touch S Pen stylus" Area 0 0 62992 35433
      xsetwacom set "Wacom Intuos5 touch S Pen stylus" CursorProximity 63
      xsetwacom set "Wacom Intuos5 touch S Pen eraser" Rotate half
      xsetwacom set "Wacom Intuos5 touch S Pen eraser" Mode Relative
      xsetwacom set "Wacom Intuos5 touch S Pen eraser" Area 0 0 62992 35433
      xsetwacom set "Wacom Intuos5 touch S Pen eraser" CursorProximity 63

      xsetwacom set "Wacom Intuos5 touch S Pad pad" Button 3 key "ctrl z"
      xsetwacom set "Wacom Intuos5 touch S Pad pad" Button 2 key "ctrl y"

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
