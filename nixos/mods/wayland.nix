{ pkgs, lib, username, ... }:
let user = username;
in {
  hardware.opengl.enable = true;

  environment.variables =
    let
      profileDir = "/nix/var/nix/profiles/per-user/${username}";
      homePath = profileDir + "/home-manager/home-path";
    in
    {
      # https://github.com/WayfireWM/wayfire/wiki/FAQ#2-the-mouse-cursor-is-invisible
      WLR_NO_HARDWARE_CURSORS = "1";

      WAYFIRE_PLUGIN_XML_PATH = "${homePath}/share/wayfire/metadata";
      WAYFIRE_PLUGIN_PATH = "${homePath}/lib/wayfire";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        inherit user;
        command = "${
            lib.makeBinPath [ pkgs.greetd.tuigreet ]
          }/tuigreet --time --cmd wayfire &> .wayfire.txt";
      };
      initial_session = {
        inherit user;
        command = "wayfire &> .wayfire.txt";
      };
    };
  };
}
