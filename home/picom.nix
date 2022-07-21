{ config, lib, pkgs, my, ... }:

{
  # activate service when it's finally installed
  services.picom = {
    enable = true;
    backend = "glx";
    experimentalBackends = true;
    fade = true;
    fadeDelta = 5;
    vSync = true;
    shadow = true;
    shadowOpacity = 0.16;
    shadowExclude = [
      "class_g = 'eww-bar'"
      "name = 'Picture-in-Picture'"

      # Tabbed windows
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"

      # Screen sharing
      "name = 'cpt_frame_xcb_window'"
      "class_g ?= 'zoom'"
      "name = 'rect-overlay'"
    ];
    opacityRules = [
      "0:_NET_WM_STATE@[0]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[1]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[2]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[3]:32a *= '_NET_WM_STATE_HIDDEN'"
      "0:_NET_WM_STATE@[4]:32a *= '_NET_WM_STATE_HIDDEN'"
    ];
    wintypes = {
      dock = {
        shadow = false;
        full-shadow = false;
      };
      toolbar = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      menu = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      utility = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      splash = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      dialog = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      dropdown_menu = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      popup_menu = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      tooltip = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      notification = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      combo = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      dnd = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
      unknown = {
        shadow = false;
        blur-background = false;
        full-shadow = false;
        fade = false;
      };
    };
    settings = rec {
      blur = {
        method = "dual_kawase";
        strength = 12;
      };

      shadow-color = my.palette."0F";
      shadow-radius = 24;
      shadow-offset-x = -shadow-radius + 0;
      shadow-offset-y = -shadow-radius + 8;

      corner-radius = 8;

      blur-background-exclude = [
        # Screen sharing
        "class_g ?= 'zoom'"
        "name = 'rect-overlay'"
      ];

      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'toolbar'"
        "window_type = 'menu'"
        "window_type = 'utility'"
        "window_type = 'splash'"
        "window_type = 'dialog'"
        "window_type = 'dropdown_menu'"
        "window_type = 'popup_menu'"
        "window_type = 'tooltip'"
        "window_type = 'notification'"
        "window_type = 'combo'"
        "window_type = 'dnd'"
        "window_type = 'unknown'"

        "class_g = 'eww-bar'"
        "name = 'Picture-in-Picture'"
      ];
    };
  };
}
