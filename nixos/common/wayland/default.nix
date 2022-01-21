{ pkgs, lib, system, username, nixpkgs-wayland, ... }:
let user = username; in
{
  hardware.opengl.enable = true;

  # pull specific packages (built against inputs.nixpkgs, usually `nixos-unstable`)
  environment.systemPackages = with pkgs; [
    nixpkgs-wayland.packages.${system}.wayfire
    nixpkgs-wayland.packages.${system}.wlr-randr
  ];

  # https://github.com/WayfireWM/wayfire/wiki/FAQ#2-the-mouse-cursor-is-invisible
  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        inherit user;
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd wayfire";
      };
      initial_session = {
        inherit user;
        command = "wayfire";
      };
    };
  };
}
