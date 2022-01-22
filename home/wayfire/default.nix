{ pkgs, system, ... }:
{
  # pull specific packages (built against inputs.nixpkgs, usually `nixos-unstable`)
  home.packages = with pkgs; [
    nixpkgs-wayland.packages.${system}.wayfire
    nixpkgs-wayland.packages.${system}.wlr-randr
  ];

  # https://github.com/WayfireWM/wayfire/wiki/FAQ#2-the-mouse-cursor-is-invisible
  home.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  xdg.configFile."wayfire.ini".source = ./wayfire.ini;
}
