{ ... }: {
  home.file.".xinitrc".text = ''
    xset r rate 400 40
    feh --bg-fill --no-fehbg --randomize ~/Pictures/Wallpapers/* &
    sxhkd &
    exec bspwm
  '';
}
