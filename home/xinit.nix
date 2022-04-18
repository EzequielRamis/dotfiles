{ ... }: {
  home.file.".xinitrc".text = ''
    xset r rate 400 40
    feh --bg-fill --no-fehbg --randomize ~/Pictures/Wallpapers/* &

    picom -b
    # systemctl --user import-environment XAUTHORITY DISPLAY
    # systemctl --user restart picom.service

    eww open bar &
    sxhkd &
    exec bspwm
  '';
}
