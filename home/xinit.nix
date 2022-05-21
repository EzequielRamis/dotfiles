{ pkgs, lib, ... }:
let c = "${pkgs.capitaine-cursors}/share/icons/capitaine-cursors-white";
in {
  home.file.".xinitrc".text = ''
    feh --bg-fill --no-fehbg --randomize ~/Pictures/Wallpapers/* &

    picom -b

    eww open bar &
    sxhkd &
    thunar --daemon &

    xset r rate 400 40
    xsetroot -cursor_name left_ptr
    xsetroot -xcf ${c}/cursors/left_ptr 30
    xrdb -merge ~/.Xresources

    exec bspwm
  '';
}
