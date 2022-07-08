{ config, lib, pkgs, ... }:

{
  # activate service when it's finally installed
  services.picom = {
    enable = true;
    backend = "glx";
    experimentalBackends = true;
    blur = true;
    fade = true;
    vSync = true;
    inactiveOpacity = "0.5";
  };
}
