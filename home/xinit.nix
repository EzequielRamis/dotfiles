{ pkgs, lib, secrets, ... }:
let c = "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors-white";
in {
  home.file.".xinitrc".text = ''
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
    xsetroot -xcf ${c}/cursors/left_ptr 30
    xrdb -merge ~/.Xresources

    feh --bg-fill --no-fehbg --randomize ~/Pictures/Wallpapers/Light/* &

    picom -b --experimental-backends

    eww open bar &
    sxhkd &
    pcmanfm -d &
    dunst &
    flameshot &
    playerctld &
    spotifyd &
  '' + secrets.xinitrc + ''
    exec bspwm
  '';
  home.pointerCursor = {
    name = "capitaine-cursors-white";
    package = pkgs.capitaine-cursors;
    size = 30;
    x11.enable = true;
  };
}
