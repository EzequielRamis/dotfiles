{ pkgs, system, nixpkgs-wayland, ... }:
{
  # pull specific packages (built against inputs.nixpkgs, usually `nixos-unstable`)
  home.packages = with pkgs; [
    nixpkgs-wayland.packages.${system}.wayfire
    nixpkgs-wayland.packages.${system}.wlr-randr
  ];

  xdg.configFile."wayfire.ini".source = ./wayfire.ini;
}
