{
  pkgs,
  lib,
  username,
  ...
}:
{
  home.sessionVariables = {
    TERMINAL = "kitty";
    BROWSER = "firefox";
    # https://github.com/NixOS/nixpkgs/issues/194929
    NIX_CC = "/dev/null";
    QT_QPA_PLATFORM = "wayland";
  };
}
