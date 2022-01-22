{ pkgs, lib, username, ... }:
let user = username; in
{
  hardware.opengl.enable = true;

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
