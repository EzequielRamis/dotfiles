{ ... }: {
  home.file.".xinitrc".text = ''
    sxhkd &
    xset r rate 400 40
    exec bspwm
  '';
}
