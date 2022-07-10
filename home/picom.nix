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
      blur-strength = 12

      shadow-radius = 28;
      shadow-opacity = 0.4;
      shadow-offset-x = -28;
      shadow-offset-y = -28;

      corner-radius = 8
    '';
  };
}
