{ pkgs, ... }:
{
  # pull specific packages (built against inputs.nixpkgs, usually `nixos-unstable`)
  home.packages = with pkgs; [
    wayfire
    wlr-randr
  ];

  xdg.configFile."wayfire.ini".source = ./wayfire.ini;
}
