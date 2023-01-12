{ ... }: {
  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
    # https://github.com/NixOS/nixpkgs/issues/194929
    NIX_CC = "/dev/null";
  };
  # xdg.desktopEntries.Lutris = {
  #   type = "Application";
  #   name = "Lutris";
  #   exec = "WEBKIT_DISABLE_COMPOSITING_MODE=1 lutris";
  #   genericName = "Game launcher";
  # };
}
