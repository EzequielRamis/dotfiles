{ config, lib, pkgs, ... }:

{
  # activate service when it's finally installed
  services.picom = {
    enable = true;
    backend = "glx";
    blur = true;
    fade = true;
    fadeDelta = 5;
    vSync = true;
    shadow = true;
    extraOptions = ''
      blur-method = "dual_kawase"
      blur-strength = 20

      corner-radius = 8
    '';
  };
}
