{ ... }: {
  home.file.".xinitrc".text = ''
    sxhkd &
    exec bspwm
  '';
}
