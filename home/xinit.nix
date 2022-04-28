{ ... }: {
  home.file.".xinitrc".text = ''
    xset r rate 400 40
    feh --bg-fill --no-fehbg --randomize ~/Pictures/Wallpapers/* &

    picom -b

    eww open bar &
    sxhkd &
    exec bspwm
  '';
}
