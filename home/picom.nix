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

        # Screen sharing
        "class_g ?= 'zoom'",
        "name = 'rect-overlay'",
      ];

      shadow-exclude = [
        "window_type = 'popup_menu'",
        "class_g = 'eww-bar'",
        "name = 'Picture-in-Picture'",

        # Tabbed windows
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'",

        # Screen sharing
        "name = 'cpt_frame_xcb_window'",
        "class_g ?= 'zoom'",
        "name = 'rect-overlay'",
      ];

      rounded-corners-exclude = [
        "window_type = 'popup_menu'",
        "class_g = 'eww-bar'",
        "name = 'Picture-in-Picture'"
      ];

      opacity-rule = [
        "0:_NET_WM_STATE@[0]:32a *= '_NET_WM_STATE_HIDDEN'",
        "0:_NET_WM_STATE@[1]:32a *= '_NET_WM_STATE_HIDDEN'",
        "0:_NET_WM_STATE@[2]:32a *= '_NET_WM_STATE_HIDDEN'",
        "0:_NET_WM_STATE@[3]:32a *= '_NET_WM_STATE_HIDDEN'",
        "0:_NET_WM_STATE@[4]:32a *= '_NET_WM_STATE_HIDDEN'"
      ];
    '';
  };
}
