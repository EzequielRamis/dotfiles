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

      blur-background-exclude = [
        "window_type = 'popup_menu'",
      ];

      shadow-exclude = [
        "window_type = 'popup_menu'",
        "class_g = 'eww-bar'",
        "name = 'Picture-in-Picture'"
      ];

      rounded-corners-exclude = [
        "window_type = 'popup_menu'",
        "class_g = 'eww-bar'",
        "name = 'Picture-in-Picture'"
      ];
    '';
  };
}
