{ ... }: {
  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
  };
  xdg.desktopEntries.Lutris = {
    type = "Application";
    name = "Lutris";
    exec = "WEBKIT_DISABLE_COMPOSITING_MODE=1 lutris";
    genericName = "Game launcher";
  };
}
