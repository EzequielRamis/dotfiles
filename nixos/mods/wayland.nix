{ pkgs, lib, username, ... }:
let user = username;
in {
  hardware.opengl.enable = true;

  # https://github.com/WayfireWM/wayfire/wiki/FAQ#2-the-mouse-cursor-is-invisible
  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        inherit user;
        command = "${
            lib.makeBinPath [ pkgs.greetd.tuigreet ]
          }/tuigreet --time --cmd wayfire";
      };
      initial_session = {
        inherit user;
        command = "wayfire";
      };
    };
  };
}
